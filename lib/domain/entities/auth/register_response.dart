import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {
  final String statusCode;
  final String message;

  const RegisterResponse({
    required this.statusCode,
    required this.message,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        statusCode,
        message,
      ];
}
