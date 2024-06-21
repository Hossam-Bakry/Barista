import 'package:dio/dio.dart';

class GetMyOwnRecipeDataSource {
  final Dio _dio;

  GetMyOwnRecipeDataSource(this._dio);

  Future<Response> getMyOwnRecipeData() async {
    return await _dio.get(
      "api/v1/Coffee/recipe/user",
    );
  }
}
