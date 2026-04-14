import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../core/auth/credentials_manager.dart';
import '../../../core/auth/session_manager.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/env/env.dart';
import '../../../core/env/env_manager.dart';
import '../../../core/models/app_exception.dart';
import '../../../core/router/navigation_provider.dart';
import '../../alerts/data/alert_evaluator.dart';
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
  late EnvManager _envManager;
  late Talker _talker;

  @override
  AuthState build() {
    _repository = sl<AuthRepository>();
    _credentials = sl<CredentialsManager>();
    _sessionManager = sl<SessionManager>();
    _envManager = sl<EnvManager>();
    _talker = sl<Talker>();
    _checkSession();
    return const AuthState.initial();
  }

  Future<void> _checkSession() async {
    final result = await _sessionManager.isSessionValid().run();
    final valid = result.getOrElse((_) => false);
    if (valid) {
      state = const AuthState.authenticated();
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  /// Logs the user in against [env]. The env is applied to [EnvManager]
  /// BEFORE the credentials are saved so that the verification request
  /// already targets the right host. On failure the previous env is
  /// restored so a failed testnet login doesn't leave the app pointing
  /// at testnet.
  Future<void> login({
    required String apiKey,
    required String apiSecret,
    required BinanceEnv env,
  }) async {
    state = const AuthState.authenticating();

    final previousEnv = _envManager.current.env;
    _envManager.set(env);

    final result = await _credentials
        .saveCredentials(apiKey: apiKey, apiSecret: apiSecret, env: env)
        .flatMap((_) => _repository.verifyCredentials())
        .run();

    state = result.fold(
      (err) {
        _talker.error('Login failed', err);
        // Fire-and-forget cleanup — we don't want to block the UI on a
        // secure-storage delete and we already have the user-facing error.
        _credentials.clearCredentials().run();
        // Revert env so a failed testnet login doesn't leave the app
        // pointing at testnet (EC-11 — env switches require logout).
        _envManager.set(previousEnv);
        return _stateFromError(err);
      },
      (_) {
        _talker.info('Login succeeded — env=${env.name}');
        sl<AlertEvaluator>().start();
        return const AuthState.authenticated();
      },
    );
  }

  Future<void> logout() async {
    final result = await _sessionManager.logout().run();
    result.match(
      (err) => _talker.error('Logout failed', err),
      (_) => _talker.info('Logged out.'),
    );
    ref.read(navigationProvider.notifier).clear();
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
