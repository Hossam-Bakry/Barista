import 'package:barista/domain/entities/home/update_recipe_request.dart';
import 'package:dio/dio.dart';

class UpdateRecipeDataSource {
  final Dio _dio;

  UpdateRecipeDataSource(this._dio);

  Future<Response> updateRecipe(UpdateRecipeRequest data) async {
    return await _dio.put(
      "api/v1/Coffee/recipe/${data.recipeId}",
      data: {
        "name": data.name,
        "coffeeImage": data.deviceImage,
        "coffee": data.coffee,
        "water": data.water,
        "ratio": data.ratio,
        "drewTime": data.drewTime,
        "grinder": data.grinder,
        "coffeeBeans": data.coffeeBeans,
      },
    );
  }
}
