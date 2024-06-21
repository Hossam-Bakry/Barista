import 'package:barista/core/error/failures.dart';
import 'package:barista/domain/entities/home/recipe_rate_response.dart';
import 'package:barista/domain/repository/home/get_recipe_rate_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecipeRateUseCase {
  final GetRecipeRateRepository _rateRepository;

  GetRecipeRateUseCase(this._rateRepository);

  Future<Either<Failure, List<RecipeRateResponse>>> excute(String id) async {
    return await _rateRepository.getRecipeRate(id);
  }
}
