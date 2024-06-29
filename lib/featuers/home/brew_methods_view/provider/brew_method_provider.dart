import 'package:barista/core/services/sound_service.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:expandable_fab_lite/expandable_fab_lite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/notification_service.dart';
import '../../../../core/services/web_service.dart';
import '../../../../data/data_source/home/send_rate_data_source.dart';
import '../../../../data/repository_imp/home/send_rate_repository_imp.dart';
import '../../../../domain/entities/home/recipe_info_entity.dart';
import '../../../../domain/entities/home/recipe_steps_details.dart';
import '../../../../domain/entities/home/send_rate_request.dart';
import '../../../../domain/repository/home/send_rate_repository.dart';
import '../../../../domain/use_cases/home/send_rate_use_case.dart';
import '../../../../main.dart';

class BrewMethodProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController _commentController = TextEditingController();

  late CustomTimerController controller;

  final WebServices _services = WebServices();

  late SendRateDataSource _rateDataSource;
  late SendRateRepository _rateRepository;
  late SendRateUseCase _rateUseCase;

  bool _isStart = false;
  bool _isFinished = false;

  late List<RecipeSteps> stepsDetailList;
  int _totalTime = 0;
  int _rate = 0;

  final List<RecipeStepDetails> _stepsDetails = [
    RecipeStepDetails(
      time: 10,
      description: "Pour 50g of water all the grounds are saturated",
      stepColor: const Color(0xFF894016),
    ),
    RecipeStepDetails(
      time: 5,
      description: "Stir the grounds to ensure all coffee is fully immersed",
      stepColor: Colors.grey,
    ),
    RecipeStepDetails(
      time: 15,
      description: "Wait for the coffee to bloom",
      stepColor: Colors.grey,
    ),
    RecipeStepDetails(
      time: 30,
      description: "Pour 130g of water in a spiral motion over the dark areas",
      stepColor: Colors.blueAccent,
    ),
    RecipeStepDetails(
      time: 20,
      description: "Wait for the water to drain through the grounds",
      stepColor: Colors.grey,
    ),
    RecipeStepDetails(
      time: 30,
      description: "Slowly top up the brewer with another 160g of water",
      stepColor: Colors.blueAccent,
    ),
    RecipeStepDetails(
      time: 30,
      description:
          "Wait for the water to drain through the grounds. When done remove the filter and serve.",
      stepColor: Colors.grey,
    ),
  ];
  int _stepNumber = 0;
  List<AnimationController> _controllersList = [];

  ExpandableFabController expandFabController = ExpandableFabController();
  PageController pageController = PageController();

  bool get isStart => _isStart;

  bool get isFinished => _isFinished;

  int get totalTime => _totalTime;

  List<RecipeStepDetails> get stepsDetails => _stepsDetails;

  int get stepNumber => _stepNumber;

  List<AnimationController> get controllersList => _controllersList;

  TextEditingController get commentController => _commentController;

  setRating(int value) {
    _rate = value;
    notifyListeners();
  }

  Future<bool> sendRate(int coffeeRecipeId) async {
    _rateDataSource = SendRateDataSource(_services.tokenDio);
    _rateRepository = SendRateRepositoryImp(_rateDataSource);
    _rateUseCase = SendRateUseCase(_rateRepository);

    final SharedPreferences prefs = await _prefs;

    var id = prefs.getString("updatedID");

    var data = SendRateRequset(
      comment: _commentController.text,
      rate: _rate,
      coffeRecipeId: int.parse(id ?? coffeeRecipeId.toString()),
    );

    EasyLoading.show();
    var result = await _rateUseCase.excute(data);

    return result.fold(
      (fail) {
        EasyLoading.dismiss();
        return Future.value(false);
      },
      (data) {
        EasyLoading.dismiss();
        return Future.value(true);
      },
    );
  }

  changeStartState(bool v) {
    _isStart = v;
    notifyListeners();
  }

  // 4
  // 0 1 2 3
  Future<void> increaseStepNumber() async {
    if (_stepNumber < _controllersList.length) {
      _stepNumber++;
    }
    notifyListeners();
  }

  createControllers(var v, List<RecipeSteps> steps) {
    stepsDetailList = steps;
    _controllersList = [];
    _totalTime = 0;
    for (var element in steps) {
      _controllersList.add(
        AnimationController(
          duration: Duration(
            seconds: ((double.parse(element.brewedTime).toInt()) * 60),
          ),
          vsync: v,
        ),
      );
      _totalTime += (double.parse(element.brewedTime).toInt() * 60);
    }
  }

  Future<void> play() async {
    if (!_controllersList[_stepNumber].isAnimating) {
      _controllersList[_stepNumber].forward();
    }

    notifyListeners();
  }

  pause() {
    if (_controllersList[_stepNumber].isAnimating) {
      _controllersList[_stepNumber].stop();
    }
    notifyListeners();
  }

  reset() {
    for (var element in _controllersList) {
      element.reset();
    }
    _stepNumber = 0;
    notifyListeners();
  }

  playNextStep(var function) {
    if (_stepNumber == _controllersList.length - 1) {
      if (function != null) {
        function(navigatorKey.currentState?.context);
      }
    }

    if (_stepNumber < _controllersList.length - 1) {
      increaseStepNumber().then((value) {
        SoundService.instance.playTapDownSound();
        play();
        _controllersList[_stepNumber - 1].reset();
      });
    }

    notifyListeners();
  }

  playPreviousStep() {
    if (_stepNumber > 0) {
      _stepNumber--;
      play();
      _controllersList[_stepNumber + 1].reset();
    }

    notifyListeners();
  }

  playNextAnimation(context) {
    if (_stepNumber < _controllersList.length - 1) {
      if (_controllersList[stepNumber].isCompleted) {
        increaseStepNumber().then(
          (value) {
            SoundService.instance.playTapDownSound();
            play().then(
              (value) => NotificationService.showNotification(
                title: "Next Step",
                body: "previous step: ${stepsDetailList[stepNumber].title}",
              ),
            );
          },
        );
      }
    }
    notifyListeners();
  }

  clearProviderData() {
    changeStartState(false);
    _totalTime = 0;
    _rate = 0;
    _stepNumber = 0;
    _controllersList = [];
  }

// Future<void> isFinishedAnimation({
//   context,
//   required Function action,
// }) async {
//   if (_controllersList[_controllersList.length - 1].isCompleted) {
//     print(_stepNumber);
//     print("doneeeee");
//     action();
//   }
// }
}
