import 'package:nftickets/data/models/user_model.dart';
import 'package:nftickets/data/providers/auth_data_provider.dart';

class AuthRepository {
  final AuthDataProvider _authDataProvider = AuthDataProvider();

  Future<dynamic> signUp(User user) async {
    final result = await _authDataProvider.signUp(user);
    return result.statusCode == 201 ? result.data : null;
  }

  Future<dynamic> signIn(String? id) async {
    final result = await _authDataProvider.signIn(id);
    return result.statusCode == 200 ? result.data : null;
  }
}
