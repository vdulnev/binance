import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/session_manager.dart';
import '../../../core/auth/token_manager.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/models/api_error.dart';
import '../data/auth_repository.dart';
import '../data/models/login_request.dart';
import '../data/models/two_factor_request.dart';
import 'auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repository;
  late final TokenManager _tokenManager;
  late final SessionManager _sessionManager;

  @override
  AuthState build() {
    _repository = sl<AuthRepository>();
    _tokenManager = sl<TokenManager>();
    _sessionManager = sl<SessionManager>();
    _checkSession();
    return const AuthState.unauthenticated();
  }

  Future<void> _checkSession() async {
    final valid = await _sessionManager.isSessionValid();
    if (!valid) return;

    final accessToken = await _tokenManager.getAccessToken();
    final refreshToken = await _tokenManager.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      state = AuthState.authenticated(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthState.authenticating();
    try {
      final response = await _repository.login(
        LoginRequest(email: email, password: password),
      );

      if (response.requiresTwoFactor &&
          response.twoFactorToken != null &&
          response.twoFactorType != null) {
        state = AuthState.requiresTwoFactor(
          twoFactorToken: response.twoFactorToken!,
          type: response.twoFactorType!,
        );
        return;
      }

      if (response.accessToken != null && response.refreshToken != null) {
        await _tokenManager.saveTokens(
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken!,
        );
        state = AuthState.authenticated(
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken!,
        );
        return;
      }

      state = const AuthState.error(message: 'Unexpected response from server');
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<void> verifyTwoFactor({
    required String code,
    required TwoFactorType type,
    required String twoFactorToken,
  }) async {
    state = const AuthState.authenticating();
    try {
      final response = await _repository.verifyTwoFactor(
        TwoFactorRequest(
          twoFactorToken: twoFactorToken,
          code: code,
          type: type,
        ),
      );

      if (response.accessToken != null && response.refreshToken != null) {
        await _tokenManager.saveTokens(
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken!,
        );
        state = AuthState.authenticated(
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken!,
        );
        return;
      }

      state = const AuthState.error(message: 'Verification failed');
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<void> logout() async {
    final accessToken = await _tokenManager.getAccessToken();
    try {
      if (accessToken != null) {
        await _repository.logout(accessToken);
      }
    } on DioException {
      // Best-effort revocation — always clear local state
    } finally {
      await _sessionManager.invalidateSession();
      state = const AuthState.unauthenticated();
    }
  }

  void _handleError(DioException e) {
    final error = e.error;
    if (error is ApiException) {
      if (error.isRateLimited) {
        state = const AuthState.error(
          message: 'Too many attempts. Please wait and try again.',
        );
      } else if (error.isIpBanned) {
        state = const AuthState.error(
          message: 'Access temporarily blocked. Try again later.',
        );
      } else {
        state = AuthState.error(
          message: error.error.msg,
          code: error.error.code,
        );
      }
      return;
    }

    state = const AuthState.error(
      message: 'Network error. Check your connection.',
    );
  }
}
