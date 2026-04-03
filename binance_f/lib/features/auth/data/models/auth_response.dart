import 'package:freezed_annotation/freezed_annotation.dart';

import 'two_factor_request.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    String? accessToken,
    String? refreshToken,
    @Default(false) bool requiresTwoFactor,
    String? twoFactorToken,
    TwoFactorType? twoFactorType,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
