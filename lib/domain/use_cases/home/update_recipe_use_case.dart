import 'package:barista/core/error/failure.dart';
import 'package:barista/domain/repository/home/update_recipe_repository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/home/update_recipe_request.dart';

class UpdateRecipeUseCase {
  final UpdateRecipeRepository _updateRecipeRepository;

  UpdateRecipeUseCase(this._updateRecipeRepository);

  Future<Either<Failure, dynamic>> excute(UpdateRecipeRequest data) async {
    return await _updateRecipeRepository.updateRecipe(data);
  }
}
