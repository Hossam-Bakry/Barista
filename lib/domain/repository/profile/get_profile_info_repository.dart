import 'package:barista/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class GetProfileInfoRepository {
  Future<Either<Failure, bool>> getProfileinfo();
}
