import 'package:barista/core/extensions/time_formate.dart';
import 'package:barista/data/models/home/recipe_steps_model.dart';
import 'package:barista/domain/entities/home/recipe_info_entity.dart';

class RecipeInfoModel extends RecipeInfoEntity {
  RecipeInfoModel({
    required super.id,
    required super.deviceName,
    required super.brewDeviceImage,
    required super.coffee,
    required super.water,
    required super.lossPercentage,
    required super.ratio,
    required super.brewedTime,
    required super.grinder,
    required super.recipeSteps,
    required super.createdAt,
  });

  factory RecipeInfoModel.fromJson(Map<String, dynamic> json) =>
      RecipeInfoModel(
        id: json["id"],
        deviceName: json["name"] ?? "",
        brewDeviceImage: json["imagePath"],
          coffee: num.parse(json["coffee"].toStringAsFixed(2)),
          water: json["water"],
          lossPercentage: json["lossPercentage"] ?? 0,
          ratio: json["ratio"],
          brewedTime: timeFormat(json["drewTime"]).toString(),
          grinder: json["grinder"] ?? "",
        recipeSteps: (json["steps"] as List)
            .map((e) => RecipeStepsModel.fromJson(e))
            .toList(),
          createdAt: json["creationDate"]);
}
