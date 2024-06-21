import 'package:dio/dio.dart';

import '../../../domain/entities/profile/update_user_request.dart';

class UpdateProfileDataSource {
  final Dio _dio;

  UpdateProfileDataSource(this._dio);

  Future<Response> updateProfile(UpdateprofileDataRequest data) async {
    return await _dio.put(
      "api/v1/Users/",
      data: {
        "userName": data.userName,
        "email": data.email,
        "phoneNumber": data.phoneNumber,
        "country": data.country,
        "birthDate": data.birthDate,
        "gender": data.gender,
        "profileImage": data.imagePath,
        "originalCountry": data.originalCountry,
      },
    );
  }
}
