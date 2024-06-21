import 'package:barista/core/error/failure.dart';
import 'package:barista/domain/entities/profile/update_user_request.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateProfileRepository {
  Future<Either<Failure, bool>> updateProfile(UpdateprofileDataRequest data);
}
