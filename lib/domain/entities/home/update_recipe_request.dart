class UpdateRecipeRequest {
  final String recipeId;
  final String name;
  final String deviceImage;
  final double coffee;
  final double water;
  final String ratio;
  final String drewTime;
  final String grinder;
  final String coffeeBeans;

  UpdateRecipeRequest({
    required this.recipeId,
    required this.name,
    required this.deviceImage,
    required this.coffee,
    required this.water,
    required this.ratio,
    required this.drewTime,
    required this.grinder,
    required this.coffeeBeans,
  });

  @override
  String toString() {
    return 'UpdateRecipeRequest{recipeId: $recipeId, name: $name, deviceImage: $deviceImage, coffee: $coffee, water: $water, ratio: $ratio, drewTime: $drewTime, grinder: $grinder, coffeeBeans: $coffeeBeans}';
  }
}
