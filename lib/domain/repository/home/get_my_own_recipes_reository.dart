import 'package:barista/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../entities/home/recipe_info_entity.dart';

abstract class GetMyOwnRecipesRepository {
  Future<Either<Failure, List<RecipeInfoEntity>>> getMyOwnRecipes();
}
