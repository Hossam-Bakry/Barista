import 'dart:developer';

import 'package:barista/core/error/failures.dart';
import 'package:barista/data/data_source/profile/get_profile_info_data_source.dart';
import 'package:barista/domain/entities/profile/user_data.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/repository/profile/get_profile_info_repository.dart';

class GetProfileInfoRepositoryImp extends GetProfileInfoRepository {
  final GetProfileInfoDataSource _infoDataSource;

  GetProfileInfoRepositoryImp(this._infoDataSource);

  @override
  Future<Either<Failure, bool>> getProfileinfo() async {
    var response = await _infoDataSource.getProfileInfo();

    UserData userData = UserData.fromJson(response.data);

    log(userData.toString());

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
  }
}
