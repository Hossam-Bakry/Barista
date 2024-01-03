import 'package:barista/core/error/failures.dart';
import 'package:barista/domain/repository/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUseCse {
  final AuthRepository _authRepository;

  ForgetPasswordUseCse(this._authRepository);

  Future<Either<ServerFailure, String>> excute(String email) async {
    return await _authRepository.forgetPassword(email);
  }
}
