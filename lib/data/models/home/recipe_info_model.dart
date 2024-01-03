import 'package:barista/data/models/home/recipe_steps_model.dart';
import 'package:barista/domain/entities/home/recipe_info_entity.dart';

class RecipeInfoModel extends RecipeInfoEntity {
  RecipeInfoModel({
    required super.id,
    required super.deviceName,
    required super.brewDeviceImage,
    required super.coffee,
    required super.water,
    required super.ratio,
    required super.brewedTime,
    required super.grinder,
    required super.recipeSteps,
  });

  factory RecipeInfoModel.fromJson(Map<String, dynamic> json) =>
      RecipeInfoModel(
        id: json["id"],
        deviceName: json["name"] ?? "",
        brewDeviceImage: json["imagePath"],
        coffee: json["coffee"],
        water: json["water"],
        ratio: json["ratio"],
        brewedTime: json["drewTime"],
        grinder: json["grinder"] ?? "",
        recipeSteps: (json["steps"] as List)
            .map((e) => RecipeStepsModel.fromJson(e))
            .toList(),
      );
}
