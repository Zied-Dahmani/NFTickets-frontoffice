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
        emit(ConnectivityConnectSuccess(connectionType: ConnectionType.Wifi));
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emit(ConnectivityConnectSuccess(connectionType: ConnectionType.Mobile));
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(ConnectivityDisconnectSuccess());
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
