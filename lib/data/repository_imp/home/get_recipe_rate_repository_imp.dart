import 'package:barista/core/error/failure.dart';
import 'package:barista/data/models/home/recipe_rate_model.dart';
import 'package:barista/domain/entities/home/recipe_rate_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/error/server_failure.dart';
import '../../../domain/repository/home/get_recipe_rate_repository.dart';
import '../../data_source/home/get_recipe_rate_data_source.dart';

class GetRecipeRateRepositoryImp implements GetRecipeRateRepository {
  final GetRecipeRateDateSource _getRecipeRateDateSource;

  GetRecipeRateRepositoryImp(this._getRecipeRateDateSource);

  @override
  Future<Either<Failure, List<RecipeRateResponse>>> getRecipeRate(
      String id) async {
    var response = await _getRecipeRateDateSource.getRecipeRate(id);

    try {
      if (response.statusCode == 200 && response.data["status"] == "Success") {
        List<RecipeRateResponse> dataList = [];
        Iterable listOfData = response.data["data"];

        for (var element in listOfData) {
          dataList.add(RecipeRateModel.fromJson(element));
        }

        return Right(dataList);
      } else if (response.statusCode == 200 &&
          response.data["status"] == "Fail") {
        return left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
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
