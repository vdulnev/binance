import 'package:binance_f/core/auth/session_manager.dart';
import 'package:binance_f/core/auth/token_manager.dart';
import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/models/api_error.dart';
import 'package:binance_f/features/auth/data/auth_repository.dart';
import 'package:binance_f/features/auth/data/models/auth_response.dart';
import 'package:binance_f/features/auth/data/models/login_request.dart';
import 'package:binance_f/features/auth/data/models/two_factor_request.dart';
import 'package:binance_f/features/auth/providers/auth_provider.dart';
import 'package:binance_f/features/auth/providers/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockTokenManager extends Mock implements TokenManager {}

class MockSessionManager extends Mock implements SessionManager {}

void main() {
  late MockAuthRepository mockRepo;
  late MockTokenManager mockTokenManager;
  late MockSessionManager mockSessionManager;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(const LoginRequest(email: '', password: ''));
    registerFallbackValue(
      const TwoFactorRequest(
        twoFactorToken: '',
        code: '',
        type: TwoFactorType.totp,
      ),
    );
  });

  setUp(() {
    mockRepo = MockAuthRepository();
    mockTokenManager = MockTokenManager();
    mockSessionManager = MockSessionManager();

    // Register mocks in get_it
    if (sl.isRegistered<AuthRepository>()) {
      sl.unregister<AuthRepository>();
    }
    if (sl.isRegistered<TokenManager>()) {
      sl.unregister<TokenManager>();
    }
    if (sl.isRegistered<SessionManager>()) {
      sl.unregister<SessionManager>();
    }

    sl.registerSingleton<AuthRepository>(mockRepo);
    sl.registerSingleton<TokenManager>(mockTokenManager);
    sl.registerSingleton<SessionManager>(mockSessionManager);

    when(
      () => mockSessionManager.isSessionValid(),
    ).thenAnswer((_) async => false);

    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
    sl.unregister<AuthRepository>();
    sl.unregister<TokenManager>();
    sl.unregister<SessionManager>();
  });

  group('AuthNotifier', () {
    test('initial state is unauthenticated', () {
      final state = container.read(authProvider);
      expect(state, isA<AuthUnauthenticated>());
    });

    test('login success transitions to authenticated', () async {
      when(() => mockRepo.login(any())).thenAnswer(
        (_) async =>
            const AuthResponse(accessToken: 'access', refreshToken: 'refresh'),
      );
      when(
        () => mockTokenManager.saveTokens(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      ).thenAnswer((_) async {});

      final notifier = container.read(authProvider.notifier);
      await notifier.login(email: 'test@test.com', password: 'pass');

      final state = container.read(authProvider);
      expect(state, isA<AuthAuthenticated>());
      final auth = state as AuthAuthenticated;
      expect(auth.accessToken, 'access');
      expect(auth.refreshToken, 'refresh');
    });

    test('login with 2FA transitions to requiresTwoFactor', () async {
      when(() => mockRepo.login(any())).thenAnswer(
        (_) async => const AuthResponse(
          requiresTwoFactor: true,
          twoFactorToken: '2fa-token',
          twoFactorType: TwoFactorType.totp,
        ),
      );

      final notifier = container.read(authProvider.notifier);
      await notifier.login(email: 'test@test.com', password: 'pass');

      final state = container.read(authProvider);
      expect(state, isA<AuthRequiresTwoFactor>());
      final twoFa = state as AuthRequiresTwoFactor;
      expect(twoFa.twoFactorToken, '2fa-token');
      expect(twoFa.type, TwoFactorType.totp);
    });

    test('login failure transitions to error', () async {
      when(() => mockRepo.login(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/login'),
          error: const ApiException(
            error: ApiError(code: -1000, msg: 'Invalid credentials'),
            httpStatusCode: 401,
          ),
        ),
      );

      final notifier = container.read(authProvider.notifier);
      await notifier.login(email: 'test@test.com', password: 'wrong');

      final state = container.read(authProvider);
      expect(state, isA<AuthError>());
      expect((state as AuthError).message, 'Invalid credentials');
    });

    test('logout clears state', () async {
      when(
        () => mockTokenManager.getAccessToken(),
      ).thenAnswer((_) async => 'access');
      when(() => mockRepo.logout(any())).thenAnswer((_) async {});
      when(
        () => mockSessionManager.invalidateSession(),
      ).thenAnswer((_) async {});

      final notifier = container.read(authProvider.notifier);
      await notifier.logout();

      final state = container.read(authProvider);
      expect(state, isA<AuthUnauthenticated>());
    });

    test('rate limit error shows user-friendly message', () async {
      when(() => mockRepo.login(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/login'),
          error: const ApiException(
            error: ApiError(code: -1003, msg: 'Too many requests'),
            httpStatusCode: 429,
          ),
        ),
      );

      final notifier = container.read(authProvider.notifier);
      await notifier.login(email: 'test@test.com', password: 'pass');

      final state = container.read(authProvider);
      expect(state, isA<AuthError>());
      expect(
        (state as AuthError).message,
        'Too many attempts. Please wait and try again.',
      );
    });
  });
}
