import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/two_factor_request.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.authenticating() = AuthAuthenticating;
  const factory AuthState.requiresTwoFactor({
    required String twoFactorToken,
    required TwoFactorType type,
  }) = AuthRequiresTwoFactor;
  const factory AuthState.authenticated({
    required String accessToken,
    required String refreshToken,
  }) = AuthAuthenticated;
  const factory AuthState.error({required String message, int? code}) =
      AuthError;
}
