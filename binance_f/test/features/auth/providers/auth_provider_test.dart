import 'package:binance_f/core/auth/credentials_manager.dart';
import 'package:binance_f/core/auth/session_manager.dart';
import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/auth/data/auth_repository.dart';
import 'package:binance_f/features/auth/providers/auth_provider.dart';
import 'package:binance_f/features/auth/providers/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker/talker.dart';

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

    for (final reg in [
      () => sl.isRegistered<AuthRepository>(),
      () => sl.isRegistered<CredentialsManager>(),
      () => sl.isRegistered<SessionManager>(),
      () => sl.isRegistered<Talker>(),
    ]) {
      // no-op — just to keep the lints happy
      reg();
    }
    if (sl.isRegistered<AuthRepository>()) sl.unregister<AuthRepository>();
    if (sl.isRegistered<CredentialsManager>()) {
      sl.unregister<CredentialsManager>();
    }
    if (sl.isRegistered<SessionManager>()) sl.unregister<SessionManager>();
    if (sl.isRegistered<Talker>()) sl.unregister<Talker>();

    sl.registerSingleton<AuthRepository>(mockRepo);
    sl.registerSingleton<CredentialsManager>(mockCredentials);
    sl.registerSingleton<SessionManager>(mockSessionManager);
    sl.registerSingleton<Talker>(Talker());

    when(
      () => mockSessionManager.isSessionValid(),
    ).thenAnswer((_) async => false);
    when(() => mockCredentials.clearCredentials()).thenAnswer((_) async {});
    when(
      () => mockCredentials.saveCredentials(
        apiKey: any(named: 'apiKey'),
        apiSecret: any(named: 'apiSecret'),
      ),
    ).thenAnswer((_) async {});

    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
    sl
      ..unregister<AuthRepository>()
      ..unregister<CredentialsManager>()
      ..unregister<SessionManager>()
      ..unregister<Talker>();
  });

  group('AuthNotifier', () {
    test('initial state is unauthenticated', () {
      final state = container.read(authProvider);
      expect(state, isA<AuthUnauthenticated>());
    });

    test('login success transitions to authenticated', () async {
      when(() => mockRepo.verifyCredentials()).thenAnswer((_) async {});

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's');

      expect(container.read(authProvider), isA<AuthAuthenticated>());
    });

    test(
      'invalid signature → AuthError with friendly message and clears creds',
      () async {
        when(
          () => mockRepo.verifyCredentials(),
        ).thenThrow(const AppException.invalidSignature());

        await container
            .read(authProvider.notifier)
            .login(apiKey: 'bad', apiSecret: 'bad');

        final state = container.read(authProvider);
        expect(state, isA<AuthError>());
        expect((state as AuthError).message, 'Invalid API key or secret.');
        verify(() => mockCredentials.clearCredentials()).called(1);
      },
    );

    test('rate limit error → friendly throttle message', () async {
      when(
        () => mockRepo.verifyCredentials(),
      ).thenThrow(const AppException.rateLimit(message: 'Too many requests'));

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's');

      final state = container.read(authProvider);
      expect(state, isA<AuthError>());
      expect(
        (state as AuthError).message,
        'Too many attempts. Please wait and try again.',
      );
    });

    test('IP ban → access blocked message', () async {
      when(
        () => mockRepo.verifyCredentials(),
      ).thenThrow(const AppException.ipBan(message: 'IP banned'));

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's');

      expect(
        (container.read(authProvider) as AuthError).message,
        'Access temporarily blocked. Try again later.',
      );
    });

    test('clock skew → check device time message', () async {
      when(
        () => mockRepo.verifyCredentials(),
      ).thenThrow(const AppException.clockSkew());

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's');

      expect(
        (container.read(authProvider) as AuthError).message,
        'Clock out of sync. Check your device time settings.',
      );
    });

    test('network error → check connection message', () async {
      when(
        () => mockRepo.verifyCredentials(),
      ).thenThrow(const AppException.network());

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's');

      expect(
        (container.read(authProvider) as AuthError).message,
        'Network error. Check your connection.',
      );
    });

    test('logout transitions to unauthenticated', () async {
      when(
        () => mockSessionManager.invalidateSession(),
      ).thenAnswer((_) async {});

      await container.read(authProvider.notifier).logout();

      expect(container.read(authProvider), isA<AuthUnauthenticated>());
    });
  });
}
