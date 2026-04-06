import 'package:binance_f/core/auth/credentials_manager.dart';
import 'package:binance_f/core/auth/session_manager.dart';
import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/models/api_error.dart';
import 'package:binance_f/features/auth/data/auth_repository.dart';
import 'package:binance_f/features/auth/providers/auth_provider.dart';
import 'package:binance_f/features/auth/providers/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockCredentialsManager extends Mock implements CredentialsManager {}

class MockSessionManager extends Mock implements SessionManager {}

void main() {
  late MockAuthRepository mockRepo;
  late MockCredentialsManager mockCredentials;
  late MockSessionManager mockSessionManager;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockAuthRepository();
    mockCredentials = MockCredentialsManager();
    mockSessionManager = MockSessionManager();

    if (sl.isRegistered<AuthRepository>()) {
      sl.unregister<AuthRepository>();
    }
    if (sl.isRegistered<CredentialsManager>()) {
      sl.unregister<CredentialsManager>();
    }
    if (sl.isRegistered<SessionManager>()) {
      sl.unregister<SessionManager>();
    }

    sl.registerSingleton<AuthRepository>(mockRepo);
    sl.registerSingleton<CredentialsManager>(mockCredentials);
    sl.registerSingleton<SessionManager>(mockSessionManager);

    when(
      () => mockSessionManager.isSessionValid(),
    ).thenAnswer((_) async => false);

    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
    sl.unregister<AuthRepository>();
    sl.unregister<CredentialsManager>();
    sl.unregister<SessionManager>();
  });

  group('AuthNotifier', () {
    test('initial state is unauthenticated', () {
      final state = container.read(authProvider);
      expect(state, isA<AuthUnauthenticated>());
    });

    test('login success transitions to authenticated', () async {
      when(
        () => mockCredentials.saveCredentials(
          apiKey: any(named: 'apiKey'),
          apiSecret: any(named: 'apiSecret'),
        ),
      ).thenAnswer((_) async {});
      when(() => mockRepo.verifyCredentials()).thenAnswer((_) async {});

      final notifier = container.read(authProvider.notifier);
      await notifier.login(apiKey: 'key', apiSecret: 'secret');

      final state = container.read(authProvider);
      expect(state, isA<AuthAuthenticated>());
    });

    test('login failure clears credentials and shows error', () async {
      when(
        () => mockCredentials.saveCredentials(
          apiKey: any(named: 'apiKey'),
          apiSecret: any(named: 'apiSecret'),
        ),
      ).thenAnswer((_) async {});
      when(() => mockCredentials.clearCredentials()).thenAnswer((_) async {});
      when(() => mockRepo.verifyCredentials()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/v3/account'),
          error: const ApiException(
            error: ApiError(code: -1022, msg: 'Signature invalid'),
            httpStatusCode: 400,
          ),
        ),
      );

      final notifier = container.read(authProvider.notifier);
      await notifier.login(apiKey: 'bad', apiSecret: 'bad');

      final state = container.read(authProvider);
      expect(state, isA<AuthError>());
      expect((state as AuthError).message, 'Invalid API key or secret.');
      verify(() => mockCredentials.clearCredentials()).called(1);
    });

    test('logout clears state', () async {
      when(
        () => mockSessionManager.invalidateSession(),
      ).thenAnswer((_) async {});

      final notifier = container.read(authProvider.notifier);
      await notifier.logout();

      final state = container.read(authProvider);
      expect(state, isA<AuthUnauthenticated>());
    });

    test('rate limit error shows user-friendly message', () async {
      when(
        () => mockCredentials.saveCredentials(
          apiKey: any(named: 'apiKey'),
          apiSecret: any(named: 'apiSecret'),
        ),
      ).thenAnswer((_) async {});
      when(() => mockCredentials.clearCredentials()).thenAnswer((_) async {});
      when(() => mockRepo.verifyCredentials()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/v3/account'),
          error: const ApiException(
            error: ApiError(code: -1003, msg: 'Too many requests'),
            httpStatusCode: 429,
          ),
        ),
      );

      final notifier = container.read(authProvider.notifier);
      await notifier.login(apiKey: 'key', apiSecret: 'secret');

      final state = container.read(authProvider);
      expect(state, isA<AuthError>());
      expect(
        (state as AuthError).message,
        'Too many attempts. Please wait and try again.',
      );
    });
  });
}
