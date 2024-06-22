import 'package:barista/core/extensions/time_formate.dart';
import 'package:barista/domain/entities/home/recipe_info_entity.dart';

class RecipeStepsModel extends RecipeSteps {
  const RecipeStepsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.stepLogo,
    required super.brewedTime,
  });

  factory RecipeStepsModel.fromJson(Map<String, dynamic> json) =>
      RecipeStepsModel(
        id: json["id"],
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        stepLogo: json["logo"] ?? "",
        brewedTime: timeFormat(json["drewTime"] ?? "").toString(),
      );
}
