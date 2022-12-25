import 'package:dio/dio.dart';
import 'package:nftickets/utils/constants.dart';

class EventDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> getUpcomingEvents() async {
    return await dio.request(
      kgetUpcomingEvents,
      options: Options(method: 'GET'),
    );
  }

}
