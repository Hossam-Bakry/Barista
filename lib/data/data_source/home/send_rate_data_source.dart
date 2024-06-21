import 'package:barista/domain/entities/home/send_rate_request.dart';
import 'package:dio/dio.dart';

class SendRateDataSource {
  final Dio _dio;

  SendRateDataSource(this._dio);

  Future<Response> sendRate(SendRateRequset data) async {
    return await _dio.post(
      "api/v1/Coffee/comment",
      data: {
        "comment": data.comment,
        "rate": data.rate,
        "coffeeRecipeId": data.coffeRecipeId,
      },
    );
  }
}
