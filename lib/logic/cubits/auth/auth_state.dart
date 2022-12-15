import 'package:nftickets/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadInProgress extends AuthState {}

class AuthSendCodeSuccess extends AuthState {}

class AuthTypeCodeFailure extends AuthState {}

// class AuthCodeVerifiedState extends AuthState {}

class AuthLogInSuccess extends AuthState {
  final User user;
  AuthLogInSuccess(this.user);
}

class AuthLogOutSuccess extends AuthState {}

class AuthIsFailure extends AuthState {
  final String error;
  AuthIsFailure(this.error);
}
