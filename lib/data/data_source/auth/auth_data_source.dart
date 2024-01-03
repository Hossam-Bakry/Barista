import 'package:barista/domain/entities/auth/register_request_data.dart';
import 'package:dio/dio.dart';

class AuthDataSource {
  final Dio _dio;

  AuthDataSource(this._dio);

  Future<Response> login(String email, String password) {
    return _dio.post(
      "/api/v1/Users/Login",
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  Future<Response> register(RegisterRequestData data) {
    return _dio.post(
      "/api/v1/Users/Register",
      data: {
        "userName": data.userName,
        "email": data.email,
        "country": "Egypt",
        "phoneNumber": data.phoneNumber,
        "password": data.password,
        "confirmPassword": data.confirmPassword,
      },
    );
  }

  Future<Response> verifyOTP(String email, String code) {
    return _dio.put(
      "/api/v1/Users/verify",
      data: {
        "email": email,
        "code": code,
      },
    );
  }

  Future<Response> forgetPassword(String email) {
    return _dio.post(
      "/api/v1/Users/Reset/Request",
      data: {
        "email": email,
      },
    );
  }

  Future<Response> verifyRestPassword(String email, String code) async {
    return await _dio.post(
      "/api/v1/Users/Reset",
      data: {
        "email": email,
        "seed": code,
      },
    );
  }

  Future<Response> resetPassword({
    required String password,
    required String confirmPassword,
    required String token,
  }) async {
    return await _dio.put(
      "/api/v1/Users/ChangePassword",
      options: Options(headers: {
        "Authorization": token,
      }),
      data: {
        "newPassword": password,
        "confirmNewPassword": confirmPassword,
      },
    );
  }
}
