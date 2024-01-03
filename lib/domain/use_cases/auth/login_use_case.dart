import 'package:barista/domain/repository/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/server_failure.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Either<ServerFailure, bool>> excute(
      String username, String password) async {
    return await _authRepository.login(username, password);
  }
}
