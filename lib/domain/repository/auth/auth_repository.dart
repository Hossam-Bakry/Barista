import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../entities/auth/register_request_data.dart';
import '../../entities/auth/register_response.dart';

abstract class AuthRepository {
  Future<Either<ServerFailure, String>> login(String email, String password);

  Future<Either<ServerFailure, RegisterResponse>> register(
      RegisterRequestData data);

  Future<Either<ServerFailure, bool>> verifyOTP(String email, String code);

  Future<Either<ServerFailure, String>> forgetPassword(String email);

  Future<Either<ServerFailure, String>> verifyREsetPassword(
      String email, String code);

  Future<Either<ServerFailure, String>> resetPassword({
    required String password,
    required String confirmPassword,
    required String token,
  });
}
