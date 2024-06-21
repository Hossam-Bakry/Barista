import 'package:barista/core/error/failure.dart';
import 'package:barista/domain/entities/profile/update_user_request.dart';
import 'package:barista/domain/repository/profile/update_profile_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase {
  final UpdateProfileRepository _updateProfileRepository;

  UpdateProfileUseCase(this._updateProfileRepository);

  Future<Either<Failure, bool>> excute(UpdateprofileDataRequest data) async {
    return await _updateProfileRepository.updateProfile(data);
  }
}
