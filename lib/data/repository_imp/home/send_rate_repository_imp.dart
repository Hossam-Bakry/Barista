import 'package:barista/core/error/failure.dart';
import 'package:barista/domain/entities/home/send_rate_request.dart';
import 'package:barista/domain/repository/home/send_rate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/server_failure.dart';
import '../../data_source/home/send_rate_data_source.dart';

class SendRateRepositoryImp implements SendRateRepository {
  final SendRateDataSource _rateDataSource;

  SendRateRepositoryImp(this._rateDataSource);

  @override
  Future<Either<Failure, bool>> sendRate(SendRateRequset data) async {
    try {
      var response = await _rateDataSource.sendRate(data);

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
      return left(
        ServerFailure(statusCode: error.response!.statusCode.toString()),
      );
    }
  }
}
