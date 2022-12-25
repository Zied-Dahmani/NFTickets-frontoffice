import 'package:nftickets/data/models/user_model.dart';
import 'package:nftickets/data/providers/user_data_provider.dart';
import 'package:nftickets/data/repositories/user_repository_interface.dart';

class UserRepository implements IUserRepository {
  final UserDataProvider _userDataProvider = UserDataProvider();

  @override
  Future<dynamic> signUp(User user) async {
    final result = await _userDataProvider.signUp(user);
    return result.statusCode == 201 ? result.data : null;
  }

  @override
  Future<dynamic> signIn(String? id) async {
    final result = await _userDataProvider.signIn(id);
    return result.statusCode == 200 ? User.fromJson(result.data) : null;
  }
}
