import 'package:barista/core/services/snackbar_service.dart';
import 'package:barista/core/services/web_service.dart';
import 'package:barista/data/repository_imp/auth/auth_repository_imp.dart';
import 'package:barista/domain/use_cases/auth/forget_password_use_case.dart';
import 'package:flutter/material.dart';

import '../../../data/data_source/auth/auth_data_source.dart';
import '../../../domain/repository/auth/auth_repository.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  final WebServices _webServices = WebServices();

  late AuthDataSource _authDataSource;
  late AuthRepository _authRepository;
  late ForgetPasswordUseCse _forgetPasswordUseCse;

  Future<bool> forgetPasseword(String email) async {
    _authDataSource = AuthDataSource(_webServices.freeDio);
    _authRepository = AuthRepositoryImp(_authDataSource);
    _forgetPasswordUseCse = ForgetPasswordUseCse(_authRepository);

    var response = await _forgetPasswordUseCse.excute(email);

    return response.fold(
      (fail) {
        SnackBarService.showErrorMessage(fail.message ?? "");
        return Future.value(false);
      },
      (data) {
        SnackBarService.showSuccessMessage(data);
        return Future.value(true);
      },
    );
  }
}
