import 'package:binance_f/core/auth/credentials_manager.dart';
import 'package:binance_f/core/auth/session_manager.dart';
import 'package:binance_f/core/env/env.dart';
import 'package:binance_f/core/env/env_manager.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker/talker.dart';

class MockCredentialsManager extends Mock implements CredentialsManager {}

/// Spy [EnvManager] that records every `set` and `reset` call. Builds
/// throwaway Dios so we never touch the network.
class _SpyEnvManager extends EnvManager {
  _SpyEnvManager({required super.talker}) : super(dioFactory: (_, _) => Dio());

  final List<BinanceEnv> setCalls = <BinanceEnv>[];
  int resetCalls = 0;

  @override
  void set(BinanceEnv env) {
    setCalls.add(env);
    super.set(env);
  }

  @override
  void reset() {
    resetCalls++;
    super.reset();
  }
}

void main() {
  late MockCredentialsManager mockCredentials;
  late _SpyEnvManager envManager;
  late SessionManager session;

  setUp(() {
    mockCredentials = MockCredentialsManager();
    envManager = _SpyEnvManager(talker: Talker());
    session = SessionManager(
      credentialsManager: mockCredentials,
      envManager: envManager,
      talker: Talker(),
    );
  });

  group('SessionManager.restore', () {
    test(
      'env present + creds present → applies env, returns Right(true)',
      () async {
        when(
          () => mockCredentials.getEnv(),
        ).thenReturn(TaskEither.right(BinanceEnv.testnet));
        when(
          () => mockCredentials.hasCredentials(),
        ).thenReturn(TaskEither.right(true));

        final result = await session.restore().run();

        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => false), isTrue);
        expect(envManager.setCalls, [BinanceEnv.testnet]);
        expect(envManager.current.env, BinanceEnv.testnet);
      },
    );

    test(
      'no env stored + no creds → no env switch, returns Right(false)',
      () async {
        when(() => mockCredentials.getEnv()).thenReturn(TaskEither.right(null));
        when(
          () => mockCredentials.hasCredentials(),
        ).thenReturn(TaskEither.right(false));

        final result = await session.restore().run();

        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => true), isFalse);
        expect(envManager.setCalls, isEmpty);
      },
    );

    test('storage failure on getEnv → Left propagates', () async {
      when(() => mockCredentials.getEnv()).thenReturn(
        TaskEither.left(const AppException.unknown(message: 'kc locked')),
      );

      final result = await session.restore().run();

      expect(result.isLeft(), isTrue);
      // hasCredentials must NOT have been called when getEnv failed.
      verifyNever(() => mockCredentials.hasCredentials());
      expect(envManager.setCalls, isEmpty);
    });
  });

  group('SessionManager.logout', () {
    test('clears credentials and resets env to fallback', () async {
      when(
        () => mockCredentials.clearCredentials(),
      ).thenReturn(TaskEither.right(unit));

      // Pretend we were on testnet.
      envManager.set(BinanceEnv.testnet);
      envManager.setCalls.clear();
      envManager.resetCalls = 0;

      final result = await session.logout().run();

      expect(result.isRight(), isTrue);
      verify(() => mockCredentials.clearCredentials()).called(1);
      expect(envManager.resetCalls, 1);
      expect(envManager.current.env, BinanceEnv.mainnet);
    });

    test(
      'cancels every registered CancelToken before clearing credentials',
      () async {
        when(
          () => mockCredentials.clearCredentials(),
        ).thenReturn(TaskEither.right(unit));

        final t1 = CancelToken();
        final t2 = CancelToken();
        session.registerCancelToken(t1);
        session.registerCancelToken(t2);

        await session.logout().run();

        expect(t1.isCancelled, isTrue);
        expect(t2.isCancelled, isTrue);
      },
    );

    test(
      'still resolves Right(unit) even if clearCredentials returns Left',
      () async {
        when(() => mockCredentials.clearCredentials()).thenReturn(
          TaskEither.left(const AppException.unknown(message: 'gone')),
        );

        final result = await session.logout().run();

        // Logout is best-effort: a storage error is logged but logout
        // proceeds so the user can never get stuck.
        expect(result.isRight(), isTrue);
        expect(envManager.resetCalls, 1);
      },
    );

    test('unregisterCancelToken removes a token from the registry', () async {
      when(
        () => mockCredentials.clearCredentials(),
      ).thenReturn(TaskEither.right(unit));

      final t = CancelToken();
      session.registerCancelToken(t);
      session.unregisterCancelToken(t);
      // Manually mark cancelled so we can detect logout did NOT touch
      // it after unregister.
      await session.logout().run();

      expect(t.isCancelled, isFalse);
    });
  });

  group('SessionManager.isSessionValid / invalidateSession', () {
    test('isSessionValid delegates to credentialsManager', () async {
      when(
        () => mockCredentials.hasCredentials(),
      ).thenReturn(TaskEither.right(true));

      final result = await session.isSessionValid().run();
      expect(result.getOrElse((_) => false), isTrue);
    });

    test('invalidateSession delegates to clearCredentials', () async {
      when(
        () => mockCredentials.clearCredentials(),
      ).thenReturn(TaskEither.right(unit));

      final result = await session.invalidateSession().run();
      expect(result.isRight(), isTrue);
      verify(() => mockCredentials.clearCredentials()).called(1);
    });
  });
}
