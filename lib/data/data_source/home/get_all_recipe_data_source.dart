import 'package:dio/dio.dart';

class GetAllRecipesDataSource {
  final Dio _dio;

  GetAllRecipesDataSource(this._dio);

  Future<Response> getAllRecipes() async {
    return await _dio.get(
      "api/v1/Coffee/recipe",
    );
  }
}
