import 'package:binance_f/core/auth/credentials_manager.dart';
import 'package:binance_f/core/auth/session_manager.dart';
import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/env/env.dart';
import 'package:binance_f/core/env/env_manager.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/auth/data/auth_repository.dart';
import 'package:binance_f/features/auth/providers/auth_provider.dart';
import 'package:binance_f/features/auth/providers/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker/talker.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockCredentialsManager extends Mock implements CredentialsManager {}

class MockSessionManager extends Mock implements SessionManager {}

/// Spy [EnvManager] that records every `set` call. We don't want to build
/// real Dios in a unit test, so the factory hands back a no-op stub.
class _SpyEnvManager extends EnvManager {
  _SpyEnvManager({required super.talker}) : super(dioFactory: (_, _) => Dio());

  final List<BinanceEnv> setCalls = <BinanceEnv>[];

  @override
  void set(BinanceEnv env) {
    setCalls.add(env);
    super.set(env);
  }
}

void main() {
  late MockAuthRepository mockRepo;
  late MockCredentialsManager mockCredentials;
  late MockSessionManager mockSessionManager;
  late _SpyEnvManager spyEnv;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(BinanceEnv.mainnet);
  });

  setUp(() {
    mockRepo = MockAuthRepository();
    mockCredentials = MockCredentialsManager();
    mockSessionManager = MockSessionManager();
    spyEnv = _SpyEnvManager(talker: Talker());

    if (sl.isRegistered<AuthRepository>()) sl.unregister<AuthRepository>();
    if (sl.isRegistered<CredentialsManager>()) {
      sl.unregister<CredentialsManager>();
    }
    if (sl.isRegistered<SessionManager>()) sl.unregister<SessionManager>();
    if (sl.isRegistered<EnvManager>()) sl.unregister<EnvManager>();
    if (sl.isRegistered<Talker>()) sl.unregister<Talker>();

    sl.registerSingleton<AuthRepository>(mockRepo);
    sl.registerSingleton<CredentialsManager>(mockCredentials);
    sl.registerSingleton<SessionManager>(mockSessionManager);
    sl.registerSingleton<EnvManager>(spyEnv);
    sl.registerSingleton<Talker>(Talker());

    when(
      () => mockSessionManager.isSessionValid(),
    ).thenReturn(TaskEither.right(false));
    when(
      () => mockCredentials.clearCredentials(),
    ).thenReturn(TaskEither.right(unit));
    when(
      () => mockCredentials.saveCredentials(
        apiKey: any(named: 'apiKey'),
        apiSecret: any(named: 'apiSecret'),
        env: any(named: 'env'),
      ),
    ).thenReturn(TaskEither.right(unit));

    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
    sl
      ..unregister<AuthRepository>()
      ..unregister<CredentialsManager>()
      ..unregister<SessionManager>()
      ..unregister<EnvManager>()
      ..unregister<Talker>();
  });

  group('AuthNotifier', () {
    test('initial state is unauthenticated', () {
      final state = container.read(authProvider);
      expect(state, isA<AuthUnauthenticated>());
    });

    test('login success transitions to authenticated', () async {
      when(
        () => mockRepo.verifyCredentials(),
      ).thenReturn(TaskEither.right(unit));

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's', env: BinanceEnv.mainnet);

      expect(container.read(authProvider), isA<AuthAuthenticated>());
    });

    test('login with testnet sets EnvManager BEFORE saving creds', () async {
      when(
        () => mockRepo.verifyCredentials(),
      ).thenReturn(TaskEither.right(unit));

      // Spy starts on the fallback (mainnet on default --dart-define).
      expect(spyEnv.current.env, BinanceEnv.mainnet);

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's', env: BinanceEnv.testnet);

      // EnvManager.set was called with testnet exactly once.
      expect(spyEnv.setCalls, [BinanceEnv.testnet]);
      expect(spyEnv.current.env, BinanceEnv.testnet);

      // saveCredentials was called with env=testnet.
      verify(
        () => mockCredentials.saveCredentials(
          apiKey: 'k',
          apiSecret: 's',
          env: BinanceEnv.testnet,
        ),
      ).called(1);
    });

    test(
      'failed login on testnet reverts EnvManager to previous env',
      () async {
        when(
          () => mockRepo.verifyCredentials(),
        ).thenReturn(TaskEither.left(const AppException.invalidSignature()));

        // Spy is on mainnet to start.
        expect(spyEnv.current.env, BinanceEnv.mainnet);

        await container
            .read(authProvider.notifier)
            .login(apiKey: 'bad', apiSecret: 'bad', env: BinanceEnv.testnet);

        // First set switches to testnet, second set reverts back to mainnet.
        expect(spyEnv.setCalls, [BinanceEnv.testnet, BinanceEnv.mainnet]);
        expect(spyEnv.current.env, BinanceEnv.mainnet);

        // Cleanup also fired.
        verify(() => mockCredentials.clearCredentials()).called(1);
      },
    );

    test(
      'invalid signature → AuthError with friendly message and clears creds',
      () async {
        when(
          () => mockRepo.verifyCredentials(),
        ).thenReturn(TaskEither.left(const AppException.invalidSignature()));

        await container
            .read(authProvider.notifier)
            .login(apiKey: 'bad', apiSecret: 'bad', env: BinanceEnv.mainnet);

        final state = container.read(authProvider);
        expect(state, isA<AuthError>());
        expect((state as AuthError).message, 'Invalid API key or secret.');
        verify(() => mockCredentials.clearCredentials()).called(1);
      },
    );

    test('rate limit error → friendly throttle message', () async {
      when(() => mockRepo.verifyCredentials()).thenReturn(
        TaskEither.left(
          const AppException.rateLimit(message: 'Too many requests'),
        ),
      );

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's', env: BinanceEnv.mainnet);

      final state = container.read(authProvider);
      expect(state, isA<AuthError>());
      expect(
        (state as AuthError).message,
        'Too many attempts. Please wait and try again.',
      );
    });

    test('IP ban → access blocked message', () async {
      when(() => mockRepo.verifyCredentials()).thenReturn(
        TaskEither.left(const AppException.ipBan(message: 'IP banned')),
      );

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's', env: BinanceEnv.mainnet);

      expect(
        (container.read(authProvider) as AuthError).message,
        'Access temporarily blocked. Try again later.',
      );
    });

    test('clock skew → check device time message', () async {
      when(
        () => mockRepo.verifyCredentials(),
      ).thenReturn(TaskEither.left(const AppException.clockSkew()));

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's', env: BinanceEnv.mainnet);

      expect(
        (container.read(authProvider) as AuthError).message,
        'Clock out of sync. Check your device time settings.',
      );
    });

    test('network error → check connection message', () async {
      when(
        () => mockRepo.verifyCredentials(),
      ).thenReturn(TaskEither.left(const AppException.network()));

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's', env: BinanceEnv.mainnet);

      expect(
        (container.read(authProvider) as AuthError).message,
        'Network error. Check your connection.',
      );
    });

    test('save credentials failure short-circuits and returns error', () async {
      when(
        () => mockCredentials.saveCredentials(
          apiKey: any(named: 'apiKey'),
          apiSecret: any(named: 'apiSecret'),
          env: any(named: 'env'),
        ),
      ).thenReturn(
        TaskEither.left(const AppException.unknown(message: 'storage offline')),
      );

      await container
          .read(authProvider.notifier)
          .login(apiKey: 'k', apiSecret: 's', env: BinanceEnv.mainnet);

      // verifyCredentials should never have been called.
      verifyNever(() => mockRepo.verifyCredentials());
      expect(container.read(authProvider), isA<AuthError>());
    });

    test(
      'logout calls SessionManager.logout and lands unauthenticated',
      () async {
        when(
          () => mockSessionManager.logout(),
        ).thenReturn(TaskEither.right(unit));

        await container.read(authProvider.notifier).logout();

        verify(() => mockSessionManager.logout()).called(1);
        expect(container.read(authProvider), isA<AuthUnauthenticated>());
      },
    );

    test(
      'logout still lands unauthenticated even if logout returns Left',
      () async {
        when(() => mockSessionManager.logout()).thenReturn(
          TaskEither.left(const AppException.unknown(message: 'storage gone')),
        );

        await container.read(authProvider.notifier).logout();

        expect(container.read(authProvider), isA<AuthUnauthenticated>());
      },
    );
  });
}
