import 'dart:convert';

import 'failure.dart';

/// General remote failures
class ServerFailure extends Failure {
  String? error, errorCode;
  String? message;

  ServerFailure({
    required super.statusCode,
    super.messageAr,
    super.messageEn,
    this.error,
    this.errorCode,
    this.message,
  });

  ServerFailure copyWith({
    String? statusCode,
    String? error,
    String? messageAr,
    String? messageEn,
    String? errorCode,
    String? message,
  }) {
    return ServerFailure(
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      messageAr: messageAr ?? this.messageAr,
      messageEn: messageEn ?? this.messageEn,
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'errorCode': errorCode,
      'error': error,
      'messageAr': super.messageAr,
      'messageEn': super.messageEn,
    };
  }

  factory ServerFailure.fromMap(Map<String, dynamic> map) {
    return ServerFailure(
      statusCode: map['statusCode'] ?? '',
      error: map['error'],
      messageAr: map['messageAr'],
      messageEn: map['messageEn'],
      errorCode: map['errorCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerFailure.fromJson(String source) =>
      ServerFailure.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServerFailure(statusCode: $statusCode, errorCode: $errorCode, error: $error, messageAr: ${super.messageAr}, messageEn: ${super.messageEn})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServerFailure &&
        other.statusCode == statusCode &&
        other.errorCode == errorCode &&
        other.error == error &&
        other.messageAr == messageAr &&
        other.messageEn == messageEn;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        error.hashCode ^
        errorCode.hashCode ^
        messageAr.hashCode ^
        messageEn.hashCode;
  }
}
