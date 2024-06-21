import 'package:barista/core/services/snackbar_service.dart';
import 'package:barista/core/services/web_service.dart';
import 'package:barista/data/data_source/auth/auth_data_source.dart';
import 'package:barista/data/repository_imp/auth/auth_repository_imp.dart';
import 'package:barista/domain/entities/auth/register_request_data.dart';
import 'package:barista/domain/entities/auth/register_response.dart';
import 'package:barista/domain/repository/auth/auth_repository.dart';
import 'package:barista/domain/use_cases/auth/login_use_case.dart';
import 'package:barista/domain/use_cases/auth/register_use_case.dart';
import 'package:barista/domain/use_cases/auth/reset_password_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/page_route_names.dart';
import '../../../core/services/biometrics_service.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../core/services/toast_service.dart';
import '../../../main.dart';

class AuthProvider extends ChangeNotifier {
  String _authType = "Login";
  ButtonState _authButtonState = ButtonState.idle;

  final WebServices _webServices = WebServices();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _genderList = [
    'male',
    'female',
  ];

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  late AuthDataSource _authDataSource;
  late AuthRepository _authRepository;
  late RegisterUseCase _registerUseCase;
  late LoginUseCase _loginrUseCase;
  late ResetPasswordUseCase _resetPasswordUseCase;
  late RegisterResponse _registerData;

  List<String> get genderList => _genderList;

  RegisterResponse get registerData => _registerData;

  String get authType => _authType;

  ButtonState get authButtonState => _authButtonState;

  void changeAuthUI(String v) {
    _authType = v;
    notifyListeners();
  }

  void setAuthButtonState(ButtonState state) {
    _authButtonState = state;
    notifyListeners();
  }

  Future<bool> register(RegisterRequestData data) async {
    _authDataSource = AuthDataSource(_webServices.freeDio);
    _authRepository = AuthRepositoryImp(_authDataSource);
    _registerUseCase = RegisterUseCase(_authRepository);

    var response = await _registerUseCase.excute(data);

    return response.fold(
      (fail) {
        SnackBarService.showErrorMessage(fail.message ?? "");
        _authButtonState = ButtonState.idle;
        return Future.value(false);
      },
      (data) {
        _registerData = data;
        notifyListeners();
        return Future.value(true);
      },
    );
  }

  Future<bool> login(
      {required String username, required String password}) async {
    _authDataSource = AuthDataSource(_webServices.freeDio);
    _authRepository = AuthRepositoryImp(_authDataSource);
    _loginrUseCase = LoginUseCase(_authRepository);

    var response = await _loginrUseCase.excute(username, password);

    SecureStorageService().put(key: 'userName', value: username);
    SecureStorageService().put(key: 'password', value: password);

    return response.fold(
      (fail) {
        SnackBarService.showErrorMessage(fail.message ?? "");
        _authButtonState = ButtonState.idle;
        notifyListeners();
        return Future.value(false);
      },
      (data) {
        setToken(data);
        notifyListeners();
        return Future.value(true);
      },
    );
  }

  Future<bool> resetPassword({
    required String password,
    required String confirmPassword,
    required String token,
  }) async {
    _authDataSource = AuthDataSource(_webServices.freeDio);
    _authRepository = AuthRepositoryImp(_authDataSource);
    _resetPasswordUseCase = ResetPasswordUseCase(_authRepository);

    EasyLoading.show();
    var response = await _resetPasswordUseCase.excute(
      password: password,
      confirmPassword: confirmPassword,
      token: token,
    );

    return response.fold(
      (fail) {
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage(fail.message ?? "");
        notifyListeners();
        return Future.value(false);
      },
      (data) {
        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage(data);
        notifyListeners();
        return Future.value(true);
      },
    );
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> setIntroState() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString("intro", "true");
  }

  Future<void> setToken(String token) {
    return _webServices.setMobileToken(token);
  }

  Future<void> loginByBiometrics() async {
    final userName = await SecureStorageService().get('userName');
    final password = await SecureStorageService().get('password');
    if (userName != null && password != null) {
      final didAuthenticate = await BiometricsService().authenticate();
      if (didAuthenticate) {
        print("Authentication");
        _emailController.text = userName;
        _passwordController.text = password;
        login(
          username: _emailController.text,
          password: _passwordController.text,
        ).then((value) {
          if (value == true) {
            EasyLoading.dismiss();
            SnackBarService.showSuccessMessage(
              "you are loged in successfully",
            );
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              PageRouteNames.home,
              (route) => false,
            );
          } else {
            EasyLoading.dismiss();
          }
        });
      }
    } else {
      ToastService.showErrorToast(
          "Something went wrong please type your credentials manually");
    }
  }
}
