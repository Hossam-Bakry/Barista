import 'package:barista/data/data_source/auth/auth_data_source.dart';
import 'package:barista/data/models/auth/register_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/auth/register_request_data.dart';
import '../../../domain/entities/auth/register_response.dart';
import '../../../domain/repository/auth/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImp(this._authDataSource);

  @override
  Future<Either<ServerFailure, bool>> login(
      String email, String password) async {
    try {
      var response = await _authDataSource.login(email, password);

      if (response.statusCode == 200 && response.data["status"] == "Success") {
        return const Right(true);
      } else if (response.statusCode == 200 &&
          response.data["status"] == "Fail") {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["data"]["message"],
          ),
        );
      } else {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print("----------");
        print(error.response?.statusCode.toString());
      }
      return Left(
        ServerFailure(
          statusCode: error.response!.statusCode.toString(),
          message: error.response?.data["message"],
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, RegisterResponse>> register(
      RegisterRequestData data) async {
    try {
      var response = await _authDataSource.register(data);
      if (response.statusCode == 200 && response.data["status"] == "Success") {
        RegisterResponse data = RegisterModel.formJson(response.data);

        return Right(data);
      } else if (response.statusCode == 200 &&
          response.data["status"] == "Fail") {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["data"]["message"],
          ),
        );
      } else {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print("----------");
        print(error.response?.statusCode.toString());
      }
      return Left(
        ServerFailure(
          statusCode: error.response!.statusCode.toString(),
          message: error.response?.data["message"],
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, bool>> verifyOTP(
    String email,
    String code,
  ) async {
    try {
      var response = await _authDataSource.verifyOTP(email, code);

      if (response.statusCode == 200 && response.data["status"] == "Success") {
        return const Right(true);
      } else if (response.statusCode == 200 &&
          response.data["status"] == "Fail") {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["data"]["message"],
          ),
        );
      } else {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print("----------");
        print(error.response?.statusCode.toString());
      }
      return Left(
        ServerFailure(
          statusCode: error.response!.statusCode.toString(),
          message: error.response?.data["message"],
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, String>> forgetPassword(String email) async {
    try {
      var response = await _authDataSource.forgetPassword(email);

      if (response.statusCode == 200 && response.data["status"] == "Success") {
        return Right(response.data["data"]["message"]);
      } else if (response.statusCode == 200 &&
          response.data["status"] == "Fail") {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["data"]["message"],
          ),
        );
      } else {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print("----------");
        print(error.response?.statusCode.toString());
      }
      return Left(
        ServerFailure(
          statusCode: error.response!.statusCode.toString(),
          message: error.response?.data["message"],
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, String>> verifyREsetPassword(
      String email, String code) async {
    try {
      var response = await _authDataSource.verifyRestPassword(email, code);

      if (response.statusCode == 200 && response.data["status"] == "Success") {
        return Right(response.data["data"]["token"]);
      } else if (response.statusCode == 200 &&
          response.data["status"] == "Fail") {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["data"]["message"],
          ),
        );
      } else {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print("----------");
        print(error.response?.statusCode.toString());
      }
      return Left(
        ServerFailure(
          statusCode: error.response!.statusCode.toString(),
          message: error.response?.data["message"],
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, String>> resetPassword({
    required String password,
    required String confirmPassword,
    required String token,
  }) async {
    try {
      var response = await _authDataSource.resetPassword(
        password: password,
        confirmPassword: confirmPassword,
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == "Success") {
        return Right(response.data["data"]["message"]);
      } else {
        return Left(
          ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["data"]["message"],
          ),
        );
      }
    } on DioError catch (error) {
      if (kDebugMode) {
        print("----------");
        print(error.response?.statusCode.toString());
      }
      return Left(
        ServerFailure(
          statusCode: error.response!.statusCode.toString(),
          message: error.response?.data["message"],
        ),
      );
    }
  }
}
