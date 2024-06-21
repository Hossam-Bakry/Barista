import 'package:barista/domain/entities/home/recipe_rate_response.dart';

class RecipeRateModel extends RecipeRateResponse {
  RecipeRateModel({
    required super.id,
    required super.rate,
    required super.comment,
  });

  factory RecipeRateModel.fromJson(Map<String, dynamic> json) =>
      RecipeRateModel(
        id: json["id"],
        rate: json["rate"] ?? 0,
        comment: json["comment"] ?? "",
      );
}
