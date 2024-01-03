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

class AuthProvider extends ChangeNotifier {
  String _authType = "Login";
  ButtonState _authButtonState = ButtonState.idle;

  final WebServices _webServices = WebServices();

  late AuthDataSource _authDataSource;
  late AuthRepository _authRepository;
  late RegisterUseCase _registerUseCase;
  late LoginUseCase _loginrUseCase;
  late ResetPasswordUseCase _resetPasswordUseCase;

  late RegisterResponse _registerData;

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

    return response.fold(
      (fail) {
        SnackBarService.showErrorMessage(fail.message ?? "");
        _authButtonState = ButtonState.idle;
        notifyListeners();
        return Future.value(false);
      },
      (data) {
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
}
