import 'package:freezed_annotation/freezed_annotation.dart';

part 'two_factor_request.freezed.dart';
part 'two_factor_request.g.dart';

enum TwoFactorType {
  @JsonValue('TOTP')
  totp,
  @JsonValue('SMS')
  sms,
}

@freezed
abstract class TwoFactorRequest with _$TwoFactorRequest {
  const factory TwoFactorRequest({
    required String twoFactorToken,
    required String code,
    required TwoFactorType type,
  }) = _TwoFactorRequest;

  factory TwoFactorRequest.fromJson(Map<String, dynamic> json) =>
      _$TwoFactorRequestFromJson(json);
}
