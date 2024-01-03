import 'package:barista/domain/repository/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/server_failure.dart';

class VerifyRestPassword {
  final AuthRepository _authRepository;

  VerifyRestPassword(this._authRepository);

  Future<Either<ServerFailure, String>> excute(
      String email, String code) async {
    return await _authRepository.verifyREsetPassword(email, code);
  }
}
