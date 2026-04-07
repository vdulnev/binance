import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../core/auth/credentials_manager.dart';
import '../../../core/auth/session_manager.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/models/app_exception.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  // `late` (not `late final`) — Riverpod may rebuild and reassign these.
  late AuthRepository _repository;
  late CredentialsManager _credentialsManager;
  late SessionManager _sessionManager;
  late Talker _talker;

  @override
  AuthState build() {
    _repository = sl<AuthRepository>();
    _credentialsManager = sl<CredentialsManager>();
    _sessionManager = sl<SessionManager>();
    _talker = sl<Talker>();
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
      await _credentialsManager.saveCredentials(
        apiKey: apiKey,
        apiSecret: apiSecret,
      );
      await _repository.verifyCredentials();
      _talker.info('Login succeeded.');
      state = const AuthState.authenticated();
    } on DioException catch (e, st) {
      await _credentialsManager.clearCredentials();
      _talker.error('Login failed', e.error ?? e, st);
      state = _stateFromError(e.error);
    } on AppException catch (e, st) {
      await _credentialsManager.clearCredentials();
      _talker.error('Login failed', e, st);
      state = _stateFromError(e);
    } catch (e, st) {
      await _credentialsManager.clearCredentials();
      _talker.error('Login failed (unexpected)', e, st);
      state = const AuthState.error(message: 'Unexpected error.');
    }
  }

  Future<void> logout() async {
    await _sessionManager.invalidateSession();
    _talker.info('Logged out.');
    state = const AuthState.unauthenticated();
  }

  AuthState _stateFromError(Object? error) {
    if (error is AppException) {
      return switch (error) {
        AuthException(:final message, :final code) => AuthState.error(
          message: message,
          code: code,
        ),
        InvalidSignatureException() => const AuthState.error(
          message: 'Invalid API key or secret.',
        ),
        ClockSkewException() => const AuthState.error(
          message: 'Clock out of sync. Check your device time settings.',
        ),
        RateLimitException() => const AuthState.error(
          message: 'Too many attempts. Please wait and try again.',
        ),
        IpBanException() => const AuthState.error(
          message: 'Access temporarily blocked. Try again later.',
        ),
        FilterViolationException(:final filter, :final message) =>
          AuthState.error(message: '$filter: $message'),
        BinanceApiException(:final code, :final message) => AuthState.error(
          message: message,
          code: code,
        ),
        NetworkException() => const AuthState.error(
          message: 'Network error. Check your connection.',
        ),
        UnknownException(:final message) => AuthState.error(
          message: message ?? 'Unknown error.',
        ),
      };
    }
    return const AuthState.error(
      message: 'Network error. Check your connection.',
    );
  }
}
