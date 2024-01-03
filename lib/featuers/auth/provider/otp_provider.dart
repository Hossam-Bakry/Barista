import 'package:barista/domain/use_cases/auth/verify_otp_use_case.dart';
import 'package:barista/domain/use_cases/auth/verify_reset_password.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../../core/services/snackbar_service.dart';
import '../../../core/services/web_service.dart';
import '../../../data/data_source/auth/auth_data_source.dart';
import '../../../data/repository_imp/auth/auth_repository_imp.dart';
import '../../../domain/repository/auth/auth_repository.dart';

class OTPProvider extends ChangeNotifier {
  ButtonState _verifyButtonState = ButtonState.idle;
  bool isDisable = true;
  bool isRest = true;

  String _tokenRestPasswordOTP = "";

  final WebServices _webServices = WebServices();

  late AuthDataSource _authDataSource;
  late AuthRepository _authRepository;
  late VerifyOTPUseCase _verifyOTPUseCase;
  late VerifyRestPassword _verifyRestPassword;

  ButtonState get verifyButtonState => _verifyButtonState;

  String get tokenRestPasswordOTP => _tokenRestPasswordOTP;

  void changeVerifyButtonDisableState(bool v) {
    isDisable = v;
    notifyListeners();
  }

  void setVerifyButtonState(ButtonState state) {
    _verifyButtonState = state;
    notifyListeners();
  }

  Future<bool> verifyOTP({required String email, required String code}) async {
    _authDataSource = AuthDataSource(_webServices.freeDio);
    _authRepository = AuthRepositoryImp(_authDataSource);
    _verifyOTPUseCase = VerifyOTPUseCase(_authRepository);

    var response = await _verifyOTPUseCase.excute(email: email, password: code);

    return response.fold(
      (fail) {
        SnackBarService.showErrorMessage(fail.message ?? "");
        notifyListeners();
        return Future.value(false);
      },
      (data) {
        notifyListeners();
        return Future.value(true);
      },
    );
  }

  Future<bool> verifyRestPassword(
      {required String email, required String code}) async {
    _authDataSource = AuthDataSource(_webServices.freeDio);
    _authRepository = AuthRepositoryImp(_authDataSource);
    _verifyRestPassword = VerifyRestPassword(_authRepository);

    var response = await _verifyRestPassword.excute(email, code);

    return response.fold(
      (fail) {
        SnackBarService.showErrorMessage(fail.message ?? "");
        notifyListeners();
        return Future.value(false);
      },
      (data) {
        _tokenRestPasswordOTP = data;
        notifyListeners();
        return Future.value(true);
      },
    );
  }
}
