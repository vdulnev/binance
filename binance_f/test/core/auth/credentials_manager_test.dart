import 'package:binance_f/core/auth/credentials_manager.dart';
import 'package:binance_f/core/security/secure_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
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
    test('saveCredentials writes both key and secret', () async {
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await credentialsManager.saveCredentials(
        apiKey: 'my-api-key',
        apiSecret: 'my-api-secret',
      );

      verify(
        () => mockStorage.write(key: 'binance_api_key', value: 'my-api-key'),
      ).called(1);
      verify(
        () => mockStorage.write(
          key: 'binance_api_secret',
          value: 'my-api-secret',
        ),
      ).called(1);
    });

    test('getApiKey reads from storage', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'my-api-key');

      final key = await credentialsManager.getApiKey();
      expect(key, 'my-api-key');
    });

    test('hasCredentials returns true when both exist', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'key');
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => 'secret');

      expect(await credentialsManager.hasCredentials(), isTrue);
    });

    test('hasCredentials returns false when key missing', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => null);
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => 'secret');

      expect(await credentialsManager.hasCredentials(), isFalse);
    });

    test('hasCredentials returns false when secret missing', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'key');
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => null);

      expect(await credentialsManager.hasCredentials(), isFalse);
    });

    test('clearCredentials deletes both entries', () async {
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});

      await credentialsManager.clearCredentials();

      verify(() => mockStorage.delete(key: 'binance_api_key')).called(1);
      verify(() => mockStorage.delete(key: 'binance_api_secret')).called(1);
    });
  });
}
