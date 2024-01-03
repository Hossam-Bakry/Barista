import 'package:equatable/equatable.dart';

class RecipeInfoEntity extends Equatable {
  int id;
  String deviceName;
  String brewDeviceImage;
  num coffee;
  num water;
  String ratio;
  num brewedTime;
  String grinder;
  List<RecipeSteps> recipeSteps;

  RecipeInfoEntity({
    required this.id,
    required this.deviceName,
    required this.brewDeviceImage,
    required this.coffee,
    required this.water,
    required this.ratio,
    required this.brewedTime,
    required this.grinder,
    required this.recipeSteps,
  });

  @override
  List<Object?> get props => [
        id,
        deviceName,
        brewDeviceImage,
        coffee,
        water,
        ratio,
        brewedTime,
        grinder,
        recipeSteps,
      ];
}

class RecipeSteps extends Equatable {
  final int id;
  final String title;
  final String description;
  final String stepLogo;
  final num brewedTime;

  const RecipeSteps({
    required this.id,
    required this.title,
    required this.description,
    required this.stepLogo,
    required this.brewedTime,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        stepLogo,
        brewedTime,
      ];
}
