import 'package:barista/core/error/failures.dart';
import 'package:barista/domain/repository/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase {
  final AuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  Future<Either<ServerFailure, String>> excute({
    required String password,
    required String confirmPassword,
    required String token,
  }) async {
    return await _authRepository.resetPassword(
      password: password,
      confirmPassword: confirmPassword,
      token: token,
    );
  }
}
