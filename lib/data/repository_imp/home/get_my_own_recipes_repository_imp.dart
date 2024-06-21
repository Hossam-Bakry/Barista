import 'package:barista/data/data_source/home/get_my_own_recipes_data_source.dart';
import 'package:barista/data/models/home/recipe_info_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/home/recipe_info_entity.dart';
import '../../../domain/repository/home/get_my_own_recipes_reository.dart';

class GetMyOwnRecipesRepositoryImp extends GetMyOwnRecipesRepository {
  final GetMyOwnRecipeDataSource _allRecipesDataSource;

  GetMyOwnRecipesRepositoryImp(this._allRecipesDataSource);

  @override
  Future<Either<Failure, List<RecipeInfoEntity>>> getMyOwnRecipes() async {
    try {
      var response = await _allRecipesDataSource.getMyOwnRecipeData();

      if (response.statusCode == 200 && response.data["status"] == "Success") {
        List<RecipeInfoEntity> list = [];

        Iterable v = response.data["data"];

        for (var element in v) {
          list.add(
            RecipeInfoModel.fromJson(element),
          );
        }
        return Right(list);
      } else if (response.statusCode == 200 &&
          response.data["status"] == "Fail") {
        return left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            // message: response.data["message"],
          ),
        );
      } else {
        return left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            // message: response.data["message"],
          ),
        );
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print(error.error);
      }
      return left(
        ServerFailure(
          statusCode: error.response!.statusCode.toString(),
        ),
      );
    }
  }
}
