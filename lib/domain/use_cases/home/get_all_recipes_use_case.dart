import 'package:barista/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/repository/home/get_all_recipes_reository.dart';
import '../../entities/home/recipe_info_entity.dart';

class GetAllRecipesUseCase {
  final GetAllRecipesRepository _allRecipesRepository;

  GetAllRecipesUseCase(this._allRecipesRepository);

  Future<Either<Failure, List<RecipeInfoEntity>>> excute() async {
    return await _allRecipesRepository.getAllRecipes();
  }
}
