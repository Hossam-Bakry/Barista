import 'package:barista/core/error/failures.dart';
import 'package:barista/domain/entities/auth/register_request_data.dart';
import 'package:barista/domain/entities/auth/register_response.dart';
import 'package:barista/domain/repository/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<Either<ServerFailure, RegisterResponse>> excute(
      RegisterRequestData data) async {
    return await _authRepository.register(data);
  }
}
