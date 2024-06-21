import 'package:barista/core/error/failure.dart';
import 'package:barista/data/data_source/home/update_recipe_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/server_failure.dart';
import '../../../domain/entities/home/update_recipe_request.dart';
import '../../../domain/repository/home/update_recipe_repository.dart';

class UpdateRecipeRepositoryImp implements UpdateRecipeRepository {
  final UpdateRecipeDataSource _updateDataSource;

  UpdateRecipeRepositoryImp(this._updateDataSource);

  @override
  Future<Either<Failure, dynamic>> updateRecipe(
      UpdateRecipeRequest data) async {
    var response = await _updateDataSource.updateRecipe(data);

    if (response.statusCode == 200 && response.data["status"] == "Success") {
      return Right(response.data["data"]["id"]);
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
  }
}
