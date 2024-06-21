import 'package:barista/core/error/failure.dart';
import 'package:barista/domain/entities/home/send_rate_request.dart';
import 'package:dartz/dartz.dart';

abstract class SendRateRepository {
  Future<Either<Failure, bool>> sendRate(SendRateRequset data);
}
