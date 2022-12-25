import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:nftickets/data/models/event_model.dart';
import 'package:nftickets/data/repositories/event_repository.dart';
import 'package:nftickets/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:nftickets/logic/cubits/event/event_state.dart';
import 'package:nftickets/utils/constants.dart';
import 'dart:developer' as developer;

class EventCubit extends Cubit<EventState> {
  EventCubit(this._connectivityCubit) : super(EventLoadInProgress()) {
    init();
  }

  final _eventRepository = EventRepository();
  final ConnectivityCubit _connectivityCubit;
  StreamSubscription? _connectivityStreamSubscription;

  StreamSubscription<ConnectivityState> init() {
    return _connectivityStreamSubscription =
        _connectivityCubit.stream.listen((connectivityState) {
      if (connectivityState is ConnectivityConnectSuccess && state is! EventLoadSuccess) {
        getUpcomingEvents();
      }
      else if (connectivityState is ConnectivityDisconnectSuccess && state is EventLoadInProgress) {
        emit(EventLoadFailure(kcheckInternetConnection));
      }
    });
  }

  Future<void> getUpcomingEvents() async {
    try {
      final result = await _eventRepository.getUpcomingEvents();
      result != null
          ? emit(EventLoadSuccess(result.cast<Event>()))
          : emit(EventLoadFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch getUpcomingEvents');
      emit(EventLoadFailure(kcheckInternetConnection));
    }
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
