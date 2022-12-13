import 'package:nftickets/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCodeSent extends AuthState {}

// class AuthCodeVerifiedState extends AuthState {}

class AuthLoggedIn extends AuthState {
  final User user;
  AuthLoggedIn(this.user);
}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}

class AuthCodeIncorrectError extends AuthState {
  final String error;
  AuthCodeIncorrectError(this.error);
}
