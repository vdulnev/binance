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
  late CredentialsManager _credentials;
  late SessionManager _sessionManager;
  late Talker _talker;

  @override
  AuthState build() {
    _repository = sl<AuthRepository>();
    _credentials = sl<CredentialsManager>();
    _sessionManager = sl<SessionManager>();
    _talker = sl<Talker>();
    _checkSession();
    return const AuthState.unauthenticated();
  }

  Future<void> _checkSession() async {
    final result = await _sessionManager.isSessionValid().run();
    final valid = result.getOrElse((_) => false);
    if (valid) {
      state = const AuthState.authenticated();
    }
  }

  Future<void> login({
    required String apiKey,
    required String apiSecret,
  }) async {
    state = const AuthState.authenticating();
    final result = await _credentials
        .saveCredentials(apiKey: apiKey, apiSecret: apiSecret)
        .flatMap((_) => _repository.verifyCredentials())
        .run();
    state = result.fold(
      (err) {
        _talker.error('Login failed', err);
        // Fire-and-forget cleanup — we don't want to block the UI on a
        // secure-storage delete and we already have the user-facing error.
        _credentials.clearCredentials().run();
        return _stateFromError(err);
      },
      (_) {
        _talker.info('Login succeeded.');
        return const AuthState.authenticated();
      },
    );
  }

  Future<void> logout() async {
    await _sessionManager.invalidateSession().run();
    _talker.info('Logged out.');
    state = const AuthState.unauthenticated();
  }

  AuthState _stateFromError(AppException error) {
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
}
