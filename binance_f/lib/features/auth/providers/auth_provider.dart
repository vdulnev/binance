import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/credentials_manager.dart';
import '../../../core/auth/session_manager.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/models/api_error.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late AuthRepository _repository;
  late CredentialsManager _credentialsManager;
  late SessionManager _sessionManager;

  @override
  AuthState build() {
    _repository = sl<AuthRepository>();
    _credentialsManager = sl<CredentialsManager>();
    _sessionManager = sl<SessionManager>();
    _checkSession();
    return const AuthState.unauthenticated();
  }

  Future<void> _checkSession() async {
    final valid = await _sessionManager.isSessionValid();
    if (valid) {
      state = const AuthState.authenticated();
    }
  }

  Future<void> login({
    required String apiKey,
    required String apiSecret,
  }) async {
    state = const AuthState.authenticating();
    try {
      // Store credentials first so the SigningInterceptor can use them.
      await _credentialsManager.saveCredentials(
        apiKey: apiKey,
        apiSecret: apiSecret,
      );

      // Verify by calling a signed endpoint.
      await _repository.verifyCredentials();

      state = const AuthState.authenticated();
    } on DioException catch (e) {
      // Credentials failed — clear them.
      await _credentialsManager.clearCredentials();
      _handleError(e);
    }
  }

  Future<void> logout() async {
    await _sessionManager.invalidateSession();
    state = const AuthState.unauthenticated();
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
      } else if (error.isInvalidSignature) {
        state = const AuthState.error(message: 'Invalid API key or secret.');
      } else if (error.isTimestampError) {
        state = const AuthState.error(
          message: 'Clock out of sync. Check your device time settings.',
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
