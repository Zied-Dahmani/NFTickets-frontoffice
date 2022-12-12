import 'package:dio/dio.dart';
import 'package:nftickets/data/models/user_model.dart';
import 'package:nftickets/utils/constants.dart';

class AuthDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 10000
    ..options.receiveTimeout = 10000;

  Future<Response> signUp(User user) async {
    return await dio.request(
      ksignUp,
      data: user.toJson(),
      options: Options(method: 'POST'),
    );
  }

  Future<Response> signIn(String? id) async {
    return await dio.request(
      ksignIn,
      data: {'id': id},
      options: Options(method: 'POST'),
    );
  }
}
