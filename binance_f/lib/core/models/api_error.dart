import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
abstract class ApiError with _$ApiError {
  const factory ApiError({required int code, required String msg}) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

class ApiException implements Exception {
  const ApiException({required this.error, this.httpStatusCode});

  final ApiError error;
  final int? httpStatusCode;

  bool get isRateLimited => httpStatusCode == 429;
  bool get isIpBanned => httpStatusCode == 418;
  bool get isInvalidSignature => error.code == -1022;
  bool get isTimestampError => error.code == -1021;

  @override
  String toString() => 'ApiException(${error.code}: ${error.msg})';
}
