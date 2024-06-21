import 'package:dio/dio.dart';

class GetProfileInfoDataSource {
  final Dio _dio;

  GetProfileInfoDataSource(this._dio);

  Future<Response> getProfileInfo() async {
    return _dio.get(
      "api/v1/Users/currentUser",
    );
  }
}
