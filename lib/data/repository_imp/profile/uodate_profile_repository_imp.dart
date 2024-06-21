import 'package:barista/core/error/failure.dart';
import 'package:barista/data/data_source/profile/update_profile_data_source.dart';
import 'package:barista/domain/entities/profile/update_user_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/server_failure.dart';
import '../../../domain/repository/profile/update_profile_repository.dart';

class UpdateProfileRepositoryimp implements UpdateProfileRepository {
  final UpdateProfileDataSource _updateProfileDataSource;

  UpdateProfileRepositoryimp(this._updateProfileDataSource);

  @override
  Future<Either<Failure, bool>> updateProfile(
      UpdateprofileDataRequest data) async {
    try {
      var response = await _updateProfileDataSource.updateProfile(data);

      if (response.statusCode == 200 && response.data["status"] == "Success") {
        return const Right(true);
      } else if (response.statusCode == 200 &&
          response.data["status"] == "Fail") {
        return left(
          ServerFailure(statusCode: response.statusCode.toString()),
        );
      } else {
        return left(
          ServerFailure(statusCode: response.statusCode.toString()),
        );
      }
    } on DioError catch (error) {
      print("False--------------------------------");
      return left(
        ServerFailure(statusCode: error.response!.statusCode.toString()),
      );
    }
  }
}
