import 'package:barista/domain/repository/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/server_failure.dart';

class VerifyOTPUseCase {
  final AuthRepository _authRepository;

  VerifyOTPUseCase(this._authRepository);

  Future<Either<ServerFailure, bool>> excute({
    required String email,
    required String password,
  }) async {
    return await _authRepository.verifyOTP(email, password);
  }
}
