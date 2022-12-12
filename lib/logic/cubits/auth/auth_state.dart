
import 'package:nftickets/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCodeSentState extends AuthState {}

// class AuthCodeVerifiedState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User user;
  AuthLoggedInState(this.user);
}

class AuthLoggedOutState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState(this.error);
}

class AuthCodeNotSentErrorState extends AuthState {
  final String error;
  AuthCodeNotSentErrorState(this.error);
}

class AuthCodeIncorrectErrorState extends AuthState {
  final String error;
  AuthCodeIncorrectErrorState(this.error);
}