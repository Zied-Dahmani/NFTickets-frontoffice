import 'package:nftickets/data/models/user_model.dart';

abstract class IAuthRepository {
  Future<dynamic> signUp(User user);
  Future<dynamic> signIn(String? id);
}
