import 'package:nftickets/data/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadInProgress extends UserState {}

class UserSendCodeSuccess extends UserState {}

class UserTypeCodeFailure extends UserState {}

// class UserCodeVerifiedState extends UserState {}

class UserLogInSuccess extends UserState {
  final User user;
  UserLogInSuccess(this.user);
}

class UserLogOutSuccess extends UserState {}

class UserIsFailure extends UserState {
  final String error;
  UserIsFailure(this.error);
}
