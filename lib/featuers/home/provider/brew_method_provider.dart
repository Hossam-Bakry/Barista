import 'package:expandable_fab_lite/expandable_fab_lite.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/home/recipe_info_entity.dart';

class BrewMethodProvider extends ChangeNotifier {
  ExpandableFabController controller = ExpandableFabController();
  PageController pageController = PageController();

  RecipeInfoEntity? recipeInfoEntity;

  BrewMethodProvider({this.recipeInfoEntity});

  double _coffee = 0;
  double _water = 0;
  double _ratio = 0;

  int _counter = 1;

  double get coffee => _coffee;

  double get water => _water;

  int get counter => _counter;

  calculateRatio() {}

  changeCoffeeDose(double value) {
    _coffee = value;
    notifyListeners();
  }

  changeWaterDose(double value) {
    _water = value;
    notifyListeners();
  }

  calculateCoffee() {}

  calculateWater() {}

  calculateDoseAmounts(RecipeInfoEntity data) {
    int counter = 1;

    int ratio = int.parse(data.ratio.toString().split(":").last);

    data.water = ratio * data.coffee;
    data.coffee = data.water / ratio;

    notifyListeners();
  }
}
