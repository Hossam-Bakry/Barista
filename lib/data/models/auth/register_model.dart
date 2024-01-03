import 'package:barista/domain/entities/auth/register_response.dart';

class RegisterModel extends RegisterResponse {
  const RegisterModel({
    required super.statusCode,
    required super.message,
  });

  factory RegisterModel.formJson(Map<String, dynamic> json) => RegisterModel(
        statusCode: json["statusCode"] ?? "",
        message: json["data"]["message"],
      );
}
