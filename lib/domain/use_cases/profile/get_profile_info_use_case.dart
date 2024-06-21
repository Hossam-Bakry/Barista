import 'package:barista/core/error/failure.dart';
import 'package:barista/domain/repository/profile/get_profile_info_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileInfoUseCase {
  final GetProfileInfoRepository _infoRepository;

  GetProfileInfoUseCase(this._infoRepository);

  Future<Either<Failure, bool>> excute() async {
    return await _infoRepository.getProfileinfo();
  }
}
