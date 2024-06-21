import 'package:dio/dio.dart';

class GetRecipeRateDateSource {
  final Dio _dio;

  GetRecipeRateDateSource(this._dio);

  Future<Response> getRecipeRate(String id) {
    return _dio.get(
      "api/v1/Coffee/comment/$id",
    );
  }
}
