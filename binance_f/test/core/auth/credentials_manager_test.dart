import 'package:binance_f/core/auth/credentials_manager.dart';
import 'package:binance_f/core/env/env.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/core/security/secure_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorageService {}

void main() {
  late MockSecureStorage mockStorage;
  late CredentialsManager credentialsManager;

  setUp(() {
    mockStorage = MockSecureStorage();
    credentialsManager = CredentialsManager(storage: mockStorage);
  });

  group('CredentialsManager', () {
    test('saveCredentials writes key, secret, and env → Right(unit)', () async {
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      final result = await credentialsManager
          .saveCredentials(
            apiKey: 'my-api-key',
            apiSecret: 'my-api-secret',
            env: BinanceEnv.testnet,
          )
          .run();

      expect(result, isA<Right<AppException, Unit>>());
      verify(
        () => mockStorage.write(key: 'binance_api_key', value: 'my-api-key'),
      ).called(1);
      verify(
        () => mockStorage.write(
          key: 'binance_api_secret',
          value: 'my-api-secret',
        ),
      ).called(1);
      verify(
        () => mockStorage.write(key: 'binance_env', value: 'testnet'),
      ).called(1);
    });

    test('saveCredentials returns Left on storage failure', () async {
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(StateError('keychain unavailable'));

      final result = await credentialsManager
          .saveCredentials(apiKey: 'k', apiSecret: 's', env: BinanceEnv.mainnet)
          .run();

      expect(result.isLeft(), isTrue);
      result.match(
        (err) => expect(err, isA<UnknownException>()),
        (_) => fail('expected Left'),
      );
    });

    test('getApiKey reads from storage', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'my-api-key');

      final result = await credentialsManager.getApiKey().run();
      expect(result.getOrElse((_) => null), 'my-api-key');
    });

    test('getEnv parses persisted "testnet" → Right(testnet)', () async {
      when(
        () => mockStorage.read(key: 'binance_env'),
      ).thenAnswer((_) async => 'testnet');

      final result = await credentialsManager.getEnv().run();
      expect(result.getOrElse((_) => null), BinanceEnv.testnet);
    });

    test('getEnv parses persisted "mainnet" → Right(mainnet)', () async {
      when(
        () => mockStorage.read(key: 'binance_env'),
      ).thenAnswer((_) async => 'mainnet');

      final result = await credentialsManager.getEnv().run();
      expect(result.getOrElse((_) => null), BinanceEnv.mainnet);
    });

    test('getEnv returns Right(null) when nothing stored', () async {
      when(
        () => mockStorage.read(key: 'binance_env'),
      ).thenAnswer((_) async => null);

      final result = await credentialsManager.getEnv().run();
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => BinanceEnv.testnet), isNull);
    });

    test('getEnv returns Left(unknown) on malformed value', () async {
      when(
        () => mockStorage.read(key: 'binance_env'),
      ).thenAnswer((_) async => 'wonderland');

      final result = await credentialsManager.getEnv().run();
      expect(result.isLeft(), isTrue);
      result.match(
        (err) => expect(err, isA<UnknownException>()),
        (_) => fail('expected Left'),
      );
    });

    test('hasCredentials returns true when both exist', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'key');
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => 'secret');

      final result = await credentialsManager.hasCredentials().run();
      expect(result.getOrElse((_) => false), isTrue);
    });

    test('hasCredentials returns false when key missing', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => null);
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => 'secret');

      final result = await credentialsManager.hasCredentials().run();
      expect(result.getOrElse((_) => true), isFalse);
    });

    test('hasCredentials returns false when secret missing', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'key');
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => null);

      final result = await credentialsManager.hasCredentials().run();
      expect(result.getOrElse((_) => true), isFalse);
    });

    test('hasCredentials maps storage failure to Left', () async {
      when(
        () => mockStorage.read(key: any(named: 'key')),
      ).thenThrow(StateError('keychain unavailable'));

      final result = await credentialsManager.hasCredentials().run();
      expect(result.isLeft(), isTrue);
    });

    test(
      'clearCredentials deletes key, secret, and env → Right(unit)',
      () async {
        when(
          () => mockStorage.delete(key: any(named: 'key')),
        ).thenAnswer((_) async {});

        final result = await credentialsManager.clearCredentials().run();

        expect(result, isA<Right<AppException, Unit>>());
        verify(() => mockStorage.delete(key: 'binance_api_key')).called(1);
        verify(() => mockStorage.delete(key: 'binance_api_secret')).called(1);
        verify(() => mockStorage.delete(key: 'binance_env')).called(1);
      },
    );

    test('clearCredentials returns Left on storage failure', () async {
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenThrow(StateError('keychain locked'));

      final result = await credentialsManager.clearCredentials().run();
      expect(result.isLeft(), isTrue);
    });
  });
}
