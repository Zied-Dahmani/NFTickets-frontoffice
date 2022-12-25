import 'package:nftickets/data/models/user_model.dart';

abstract class IUserRepository {
  Future<dynamic> signUp(User user);
  Future<dynamic> signIn(String? id);
}
