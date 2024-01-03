import 'package:barista/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../entities/home/recipe_info_entity.dart';

abstract class GetAllRecipesRepository {
  Future<Either<Failure, List<RecipeInfoEntity>>> getAllRecipes();
}
