import 'package:barista/domain/entities/home/recipe_info_entity.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failures.dart';
import '../../../core/services/web_service.dart';
import '../../../data/data_source/home/get_all_recipe_data_source.dart';
import '../../../data/repository_imp/home/get_all_recipes_repository_imp.dart';
import '../../../domain/repository/home/get_all_recipes_reository.dart';
import '../../../domain/use_cases/home/get_all_recipes_use_case.dart';
import '../pages/brew_methods_view/brew_methods_view.dart';
import '../pages/profile/profile_view.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController coffeeController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController brewsTimeController = TextEditingController();
  TextEditingController grinderController = TextEditingController();

  final WebServices _services = WebServices();

  late GetAllRecipesDataSource _allRecipesDataSource;
  late GetAllRecipesRepository _allRecipesRepository;
  late GetAllRecipesUseCase _allRecipesUseCase;

  int _listViewSelectedIndex = 0;
  int _currentIndex = 0;
  double _coffee = 0;
  double _water = 0;
  double _ratio = 13;
  bool _isLoading = true;
  int _counter = 1;

  List<Widget> widgetList = [
    const BrewMethodsView(),
    // const CoffeeView(),
    // const CartView(),
    const ProfileView(),
  ];

  List<RecipeInfoEntity> _brewDevicesList = [];

  bool _isLocked = true;

  bool get isLocked => _isLocked;

  bool get isLoading => _isLoading;

  double get coffee => _coffee;

  double get water => _water;

  int get counter => _counter;

  List<RecipeInfoEntity> get brewDevicesList => _brewDevicesList;

  int get currentIndex => _currentIndex;

  increaseCounter() {
    _counter++;
    notifyListeners();
  }

  decreaseCounter() {
    if (_counter > 0) {
      _counter--;
    }
    notifyListeners();
  }

  setLockedStatus(bool v) {
    _isLocked = v;
    notifyListeners();
  }

  calculateRatio() {
    _ratio = 13;
    // int.parse(_brewDevicesList[_listViewSelectedIndex]
    //     .ratio
    //     .toString()
    //     .split(":")
    //     .last)
    // .toDouble();
    notifyListeners();
  }

  serRatio(double v) {
    _ratio = v;
    notifyListeners();
  }

  changeCoffeeWithUnLocked(double value) {
    coffeeController.text = (_counter * value).toString();
    notifyListeners();
  }

  changeCoffeeDose(double value) {
    _coffee = value;
    notifyListeners();
  }

  changeWaterDose(double value) {
    _water = value;
    notifyListeners();
  }

  calculateCoffee() {
    coffeeController.text =
        ((_counter * (_water / _coffee)).toStringAsFixed(1)).toString();
    notifyListeners();
  }

  calculateWater() {
    waterController.text =
        ((_counter * _ratio * _coffee).toStringAsFixed(1)).toString();
    notifyListeners();
  }

  calculateDoseAmounts(RecipeInfoEntity data) {
    int counter = 1;

    int ratio = int.parse(data.ratio.toString().split(":").last);

    data.water = ratio * data.coffee;
    data.coffee = data.water / ratio;

    notifyListeners();
  }

  String getDeviceImage(int index) {
    if (index == 0) {
      return "assets/images/brew_1.png";
    } else if (index == 1) {
      return "assets/images/brew_2.png";
    } else if (index == 2) {
      return "assets/images/brew_3.png";
    } else if (index == 3) {
      return "assets/images/brew_4.png";
    } else if (index == 4) {
      return "assets/images/brew_5.png";
    } else if (index == 5) {
      return "assets/images/brew_6.png";
    } else {
      return "assets/images/brew_7.png";
    }
  }

  void changeLoadingStatus(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void changeListViewSelectedIndex(int v) {
    _listViewSelectedIndex = v;
    notifyListeners();
  }

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<bool> getAllRecipes() async {
    _allRecipesDataSource = GetAllRecipesDataSource(_services.freeDio);
    _allRecipesRepository = GetAllRecipesRepositoryImp(_allRecipesDataSource);
    _allRecipesUseCase = GetAllRecipesUseCase(_allRecipesRepository);

    var result = await _allRecipesUseCase.excute();

    return result.fold(
      (fail) {
        var error = fail as ServerFailure;
        return Future.value(false);
      },
      (data) {
        print(data);
        _brewDevicesList = data;
        waterController.text = data[_listViewSelectedIndex].water.toString();
        coffeeController.text = data[_listViewSelectedIndex].coffee.toString();
        brewsTimeController.text =
            data[_listViewSelectedIndex].brewedTime.toString();
        grinderController.text = data[_listViewSelectedIndex].grinder;

        _coffee = data[_listViewSelectedIndex].coffee.toDouble();
        _water = data[_listViewSelectedIndex].water.toDouble();
        return Future.value(true);
      },
    );
  }
}
