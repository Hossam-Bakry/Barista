import 'package:barista/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/home/update_recipe_request.dart';

abstract class UpdateRecipeRepository {
  Future<Either<Failure, dynamic>> updateRecipe(UpdateRecipeRequest data);
}
