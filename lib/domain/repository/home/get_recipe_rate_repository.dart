import 'package:barista/domain/entities/home/recipe_rate_response.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

abstract class GetRecipeRateRepository {
  Future<Either<Failure, List<RecipeRateResponse>>> getRecipeRate(String id);
}
