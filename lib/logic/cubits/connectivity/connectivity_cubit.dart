import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nftickets/logic/cubits/connectivity/connection_type.dart';
part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityLoadInProgress()) {
    checkConnectiivty();
  }

  final Connectivity connectivity = Connectivity();
  StreamSubscription? connectivityStreamSubscription;

  StreamSubscription<ConnectivityResult> checkConnectiivty() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitConnectivityConnect(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitConnectivityConnect(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitConnectivityDisconnect();
      }
    });
  }

  void emitConnectivityConnect(ConnectionType connectionType) =>
      emit(ConnectivityConnect(connectionType: connectionType));

  void emitConnectivityDisconnect() => emit(ConnectivityDisconnect());

  @override
  Future<void> close() {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
