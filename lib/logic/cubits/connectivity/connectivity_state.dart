part of 'connectivity_cubit.dart';

abstract class ConnectivityState {}

class ConnectivityLoadInProgress extends ConnectivityState {}

class ConnectivityConnect extends ConnectivityState {
  final ConnectionType connectionType;

  ConnectivityConnect({required this.connectionType});
}

class ConnectivityDisconnect extends ConnectivityState {}
