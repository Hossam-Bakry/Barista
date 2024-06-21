import 'package:barista/core/error/failures.dart';
import 'package:barista/domain/repository/home/get_my_own_recipes_reository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/home/recipe_info_entity.dart';

class GetMyOwnRecipesUseCase {
  final GetMyOwnRecipesRepository _allRecipesRepository;

  GetMyOwnRecipesUseCase(this._allRecipesRepository);

  Future<Either<Failure, List<RecipeInfoEntity>>> excute() async {
    return await _allRecipesRepository.getMyOwnRecipes();
  }
}
