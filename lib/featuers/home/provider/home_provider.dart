// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:barista/data/repository_imp/home/get_recipe_rate_repository_imp.dart';
import 'package:barista/domain/entities/home/recipe_rate_response.dart';
import 'package:barista/domain/use_cases/home/get_recipe_rate_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart' as cropper;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/page_route_names.dart';
import '../../../core/error/failures.dart';
import '../../../core/services/web_service.dart';
import '../../../data/data_source/home/get_all_recipe_data_source.dart';
import '../../../data/data_source/home/get_my_own_recipes_data_source.dart';
import '../../../data/data_source/home/get_recipe_rate_data_source.dart';
import '../../../data/data_source/home/update_recipe_data_source.dart';
import '../../../data/data_source/profile/get_profile_info_data_source.dart';
import '../../../data/data_source/profile/update_profile_data_source.dart';
import '../../../data/repository_imp/home/get_all_recipes_repository_imp.dart';
import '../../../data/repository_imp/home/get_my_own_recipes_repository_imp.dart';
import '../../../data/repository_imp/home/update_recipe_repository_imp.dart';
import '../../../data/repository_imp/profile/get_profile_info_repository_imp.dart';
import '../../../data/repository_imp/profile/uodate_profile_repository_imp.dart';
import '../../../domain/entities/home/recipe_info_entity.dart';
import '../../../domain/entities/home/update_recipe_request.dart';
import '../../../domain/entities/profile/update_user_request.dart';
import '../../../domain/entities/profile/user_data.dart';
import '../../../domain/repository/home/get_all_recipes_reository.dart';
import '../../../domain/repository/home/get_my_own_recipes_reository.dart';
import '../../../domain/repository/home/get_recipe_rate_repository.dart';
import '../../../domain/repository/home/update_recipe_repository.dart';
import '../../../domain/repository/profile/get_profile_info_repository.dart';
import '../../../domain/repository/profile/update_profile_repository.dart';
import '../../../domain/use_cases/home/get_all_recipes_use_case.dart';
import '../../../domain/use_cases/home/get_my_own_recipes_use_case.dart';
import '../../../domain/use_cases/home/update_recipe_use_case.dart';
import '../../../domain/use_cases/profile/get_profile_info_use_case.dart';
import '../../../domain/use_cases/profile/update_profile_use_case.dart';
import '../../../featuers/home/my_own_recipe_view/pages/my_own_recipe_view.dart';
import '../../../main.dart';
import '../brew_methods_view/pages/brew_methods_view.dart';
import '../profile_view/pages/profile_view.dart';

class HomeProvider extends ChangeNotifier {
  var _userData = UserData();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  printData() {
    print(UserData().phoneNumber);
    print(UserData().country);
    print(UserData().gender);
    print(UserData().birthday);
    print(UserData().userName);

    print(UserData().imagePath);
  }

  setDefaultValue() {
    _gender = _userData.gender ?? "";
    _country = _userData.country ?? "";
    _originalCountry = _userData.originalCountry ?? "";
    _editPhoneController = TextEditingController(
      text: _userData.phoneNumber ?? "",
    );
    _editBirthDateController = TextEditingController(
      text: _userData.birthday ?? "",
    );
  }

  bool brewTimeError = false;
  bool coffeeBeansError = false;

  String _profileImage = UserData().imagePath ?? "";
  late String _country;
  late String _originalCountry;
  late String _countryCode;
  late String _originalCountryCode;
  late String _gender;
  late TextEditingController _editPhoneController;
  late TextEditingController _editBirthDateController;

  TextEditingController coffeeController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController brewsTimeController = TextEditingController();
  TextEditingController ratioController = TextEditingController();
  TextEditingController coffeeBeansController = TextEditingController();
  late String _grinderValue;

  final WebServices _services = WebServices();

  late GetAllRecipesDataSource _allRecipesDataSource;
  late GetAllRecipesRepository _allRecipesRepository;
  late GetAllRecipesUseCase _allRecipesUseCase;

  late UpdateRecipeDataSource _updateRecipeDataSource;
  late UpdateRecipeRepository _updateRecipeRepository;
  late UpdateRecipeUseCase _updateRecipeUseCase;

  late GetProfileInfoDataSource _infoDataSource;
  late GetProfileInfoRepository _infoRepository;
  late GetProfileInfoUseCase _infoUseCase;

  late GetMyOwnRecipeDataSource _getMyOwnRecipeDataSource;
  late GetMyOwnRecipesRepository _getMyOwnRecipesRepository;
  late GetMyOwnRecipesUseCase _getMyOwnRecipesUseCase;

  late UpdateProfileDataSource _updateProfileDataSource;
  late UpdateProfileRepository _updateProfileRepository;
  late UpdateProfileUseCase _updateProfileUseCase;

  late GetRecipeRateDateSource _getRecipeRateDateSource;
  late GetRecipeRateRepository _getRecipeRateRepository;
  late GetRecipeRateUseCase _getRecipeRateUseCase;

  int _listViewSelectedIndex = 0;
  int _currentIndex = 0;
  double _coffee = 0;
  double _myOwnCoffee = 0;
  double _water = 0;
  double _myOwnWater = 0;
  double _ratio = 13;
  bool _isLoading = true;
  bool _isLoadingMyOwnRecipepage = true;
  int _counter = 1;

  final List<String> _genderList = [
    'Male',
    'Female',
  ];

  List<Widget> widgetList = [
    BrewMethodsView(),
    MyOwnRecipeView(),
    ProfileView(),
  ];

  List<RecipeInfoEntity> _brewDevicesList = [];
  List<RecipeInfoEntity> _myOwnBrewDevicesList = [];

  late List<RecipeRateResponse> _rateResponseList;

  List<RecipeRateResponse> get rateResponseList => _rateResponseList;

  List<String> get genderList => _genderList;

  String get profileImage => _profileImage;
  bool _isLocked = true;

  bool get isLocked => _isLocked;

  bool get isLoading => _isLoading;

  bool get isLoadingMyOwnRecipePage => _isLoadingMyOwnRecipepage;

  double get coffee => _coffee;

  double get myOwnCoffee => _myOwnCoffee;

  double get myOwnWater => _myOwnWater;

  double get water => _water;

  int get counter => _counter;

  String get country => _country;

  String get originalCountry => _originalCountry;

  String get countryCode => _countryCode;

  String get gender => _gender;

  List<RecipeInfoEntity> get brewDevicesList => _brewDevicesList;

  List<RecipeInfoEntity> get myOwnBrewDevicesList => _myOwnBrewDevicesList;

  TextEditingController get editPhoneController => _editPhoneController;

  TextEditingController get editBirthDateController => _editBirthDateController;

  int get currentIndex => _currentIndex;

  String get grinderValue => _grinderValue;

  void changeCoffeeDoseWhenUnlocked(double coffee) {
    // _water =;
  }

  void setGrinderValue(String v) {
    _grinderValue = v;
    notifyListeners();
  }

  void setDefaultDoseValues(RecipeInfoEntity doseInfo) {
    calculateCoffee();
    // coffeeController.text = doseInfo.coffee.toString();
    waterController.text = doseInfo.water.toString();
    brewsTimeController.text = doseInfo.brewedTime.toString();
    // brewsTimeController.text = (doseInfo.brewedTime / 60).truncate().toString();
    _grinderValue = doseInfo.grinder.toString();
  }

  void increaseCounter() {
    _counter++;
    waterController.text = (_water * _counter).toString();
    print(_counter);
    print(_water);
    notifyListeners();
  }

  void decreaseCounter() {
    if (_counter > 1) {
      _counter--;
      waterController.text = (_water * _counter).toString();
      print(_counter);
      print(_water);
    }
    notifyListeners();
  }

  void setLockedStatus(bool v) {
    _isLocked = v;
    notifyListeners();
  }

  void serRatio(double v) {
    _ratio = v;
    notifyListeners();
  }

  void changeCoffeeWithUnLocked(double value) {
    coffeeController.text = (_counter * value).toString();
    notifyListeners();
  }

  void changeCoffeeDose(double value) {
    _coffee = value;
    notifyListeners();
  }

  void changeWaterDose(double value) {
    _water = value;
    notifyListeners();
  }

  double _percentageOfLoss = 0.0;

  double get percentageOfLoss => _percentageOfLoss;

  calculateCoffee() {
    coffeeController.text =
        // (((_counter * 50 * 100) / (100 - percentageOfLoss)) / _ratio)
        //     .toStringAsFixed(2)
        //     .toString();

        ((_counter * (_water / _coffee)).toStringAsFixed(1)).toString();

    notifyListeners();
  }

  calculateWater() {
    print("$_ratio--------------");
    waterController.text =
        ((_counter * _ratio * _coffee).toStringAsFixed(1)).toString();
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

  void changeBrewViewLoadingStatus(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void changeMyOwnRecipeViewLoadingStatus(bool v) {
    _isLoadingMyOwnRecipepage = v;
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

  Future<bool> getRecipeRate(String id) async {
    _getRecipeRateDateSource = GetRecipeRateDateSource(_services.tokenDio);
    _getRecipeRateRepository =
        GetRecipeRateRepositoryImp(_getRecipeRateDateSource);
    _getRecipeRateUseCase = GetRecipeRateUseCase(_getRecipeRateRepository);

    var result = await _getRecipeRateUseCase.excute(id);

    return result.fold(
      (fail) {
        var error = fail as ServerFailure;
        return Future.value(false);
      },
      (data) {
        _rateResponseList = data;
        notifyListeners();
        return Future.value(true);
      },
    );
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
        _ratio = double.parse(data[_listViewSelectedIndex].ratio.substring(2));
        _brewDevicesList = data;
        _coffee = data[_listViewSelectedIndex].coffee.toDouble();
        _percentageOfLoss =
            data[_listViewSelectedIndex].lossPercentage.toDouble();
        _water = data[_listViewSelectedIndex].water.toDouble();
        print(_water);
        print("-----------------------------------");
        return Future.value(true);
      },
    );
  }

  Future<bool> getMyOwnRecipe() async {
    _getMyOwnRecipeDataSource = GetMyOwnRecipeDataSource(_services.tokenDio);
    _getMyOwnRecipesRepository =
        GetMyOwnRecipesRepositoryImp(_getMyOwnRecipeDataSource);
    _getMyOwnRecipesUseCase =
        GetMyOwnRecipesUseCase(_getMyOwnRecipesRepository);

    var result = await _getMyOwnRecipesUseCase.excute();

    return result.fold(
      (fail) {
        var error = fail as ServerFailure;
        return Future.value(false);
      },
      (data) {
        _myOwnBrewDevicesList = data;
        if (_myOwnBrewDevicesList.isNotEmpty) {
          _myOwnCoffee = data[_listViewSelectedIndex].coffee.toDouble();
          _myOwnWater = data[_listViewSelectedIndex].water.toDouble();
        }

        return Future.value(true);
      },
    );
  }

  Future<bool> updateRecipe(UpdateRecipeRequest data) async {
    EasyLoading.show();
    _updateRecipeDataSource = UpdateRecipeDataSource(_services.tokenDio);
    _updateRecipeRepository =
        UpdateRecipeRepositoryImp(_updateRecipeDataSource);
    _updateRecipeUseCase = UpdateRecipeUseCase(_updateRecipeRepository);

    var result = await _updateRecipeUseCase.excute(data);

    return result.fold(
      (fail) {
        EasyLoading.dismiss();
        return Future.value(false);
      },
      (data) async {
        final SharedPreferences prefs = await _prefs;

        prefs.setString("updatedID", data.toString());

        EasyLoading.dismiss();
        notifyListeners();
        return Future.value(true);
      },
    );
  }

  Future<bool> getProfileInfo() async {
    _infoDataSource = GetProfileInfoDataSource(_services.tokenDio);
    _infoRepository = GetProfileInfoRepositoryImp(_infoDataSource);
    _infoUseCase = GetProfileInfoUseCase(_infoRepository);

    var result = await _infoUseCase.excute();

    return result.fold(
      (fail) {
        return Future.value(false);
      },
      (data) {
        notifyListeners();
        return Future.value(true);
      },
    );
  }

  Future<bool> updateProfileInfo() async {
    _updateProfileDataSource = UpdateProfileDataSource(_services.tokenDio);
    _updateProfileRepository =
        UpdateProfileRepositoryimp(_updateProfileDataSource);
    _updateProfileUseCase = UpdateProfileUseCase(_updateProfileRepository);

    var data = UpdateprofileDataRequest(
      userName: UserData().userName ?? "",
      email: UserData().email ?? "",
      phoneNumber: editPhoneController.text,
      imagePath: _profileImage,
      birthDate: editBirthDateController.text,
      gender: _gender,
      country: _country,
      originalCountry: _originalCountry,
    );

    print(data.toString());
    EasyLoading.show();

    var result = await _updateProfileUseCase.excute(data);

    return result.fold(
      (fail) {
        EasyLoading.dismiss();
        print("False--------------------------------");
        return Future.value(false);
      },
      (data) {
        EasyLoading.dismiss();
        notifyListeners();
        return Future.value(true);
      },
    );
  }

  Future<void> onRefresh() {
    changeBrewViewLoadingStatus(true);
    getAllRecipes().then((value) => changeBrewViewLoadingStatus(false));
    return Future.value();
  }

  Future<XFile?> _showImageCropper(String imagePath) async {
    final croppedImage = await cropper.ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      aspectRatioPresets: [
        cropper.CropAspectRatioPreset.square,
      ],
      uiSettings: [
        cropper.AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: const Color(0xFF323239),
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: const Color(0xFFE00800),
          initAspectRatio: cropper.CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: false,
        ),
        cropper.IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
    return croppedImage != null ? XFile(croppedImage.path) : null;
  }

  takeProfileImage(XFile image) async {
    final croppedImage = await _showImageCropper(image.path);
    if (croppedImage == null) return;
    List<int> imageBytes = await croppedImage.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    setImageProfile(base64Image);
    // _profileImage = base64Image;
    notifyListeners();
  }

  setImageProfile(String v) {
    _profileImage = v;
    notifyListeners();
  }

  setCountry(String country, String code) {
    _country = country;
    _countryCode = code;
    notifyListeners();
  }

  setOriginalCountry(String country, String code) {
    _originalCountry = country;
    _originalCountryCode = code;
    print("Done");
    notifyListeners();
  }

  setGender(String v) {
    _gender = v;
    notifyListeners();
  }

  Future<bool> setIntroLangState(String lang) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString("introLang", lang);
  }

  void setLanguage(String lang, BuildContext context) async {
    await context.setLocale(Locale(lang.toLowerCase()));
    setIntroLangState(lang);
    WebServices().lang = lang;
    notifyListeners();
  }

  logOut() {
    _services.setMobileToken(null);
    // user.clearUser();
    // bottomBarController.animateTo(0);
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      PageRouteNames.login,
      (route) => false,
    );
  }
}
