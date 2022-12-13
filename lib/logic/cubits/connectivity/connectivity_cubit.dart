import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nftickets/logic/cubits/connectivity/connection_type.dart';
part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityLoading()) {
    checkConnectiivty();
  }

  final Connectivity connectivity = Connectivity();
  StreamSubscription? connectivityStreamSubscription;

  StreamSubscription<ConnectivityResult> checkConnectiivty() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitConnectivityConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitConnectivityConnected(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitConnectivityDisconnected();
      }
    });
  }

  void emitConnectivityConnected(ConnectionType connectionType) =>
      emit(ConnectivityConnected(connectionType: connectionType));

  void emitConnectivityDisconnected() => emit(ConnectivityDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
