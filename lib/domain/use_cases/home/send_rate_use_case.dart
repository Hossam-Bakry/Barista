import 'package:barista/core/error/failure.dart';
import 'package:barista/domain/entities/home/send_rate_request.dart';
import 'package:barista/domain/repository/home/send_rate_repository.dart';
import 'package:dartz/dartz.dart';

class SendRateUseCase {
  final SendRateRepository _rateRepository;

  SendRateUseCase(this._rateRepository);

  Future<Either<Failure, bool>> excute(SendRateRequset data) async {
    return await _rateRepository.sendRate(data);
  }
}
