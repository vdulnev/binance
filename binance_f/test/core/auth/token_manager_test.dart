import 'package:binance_f/core/auth/token_manager.dart';
import 'package:binance_f/core/security/secure_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorageService {}

void main() {
  late MockSecureStorage mockStorage;
  late TokenManager tokenManager;

  setUp(() {
    mockStorage = MockSecureStorage();
    tokenManager = TokenManager(storage: mockStorage);
  });

  group('TokenManager', () {
    test('saveTokens writes both tokens', () async {
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await tokenManager.saveTokens(
        accessToken: 'access-123',
        refreshToken: 'refresh-456',
      );

      verify(
        () => mockStorage.write(key: 'access_token', value: 'access-123'),
      ).called(1);
      verify(
        () => mockStorage.write(key: 'refresh_token', value: 'refresh-456'),
      ).called(1);
    });

    test('getAccessToken reads from storage', () async {
      when(
        () => mockStorage.read(key: 'access_token'),
      ).thenAnswer((_) async => 'access-123');

      final token = await tokenManager.getAccessToken();
      expect(token, 'access-123');
    });

    test('hasTokens returns true when token exists', () async {
      when(
        () => mockStorage.read(key: 'access_token'),
      ).thenAnswer((_) async => 'access-123');

      expect(await tokenManager.hasTokens(), isTrue);
    });

    test('hasTokens returns false when no token', () async {
      when(
        () => mockStorage.read(key: 'access_token'),
      ).thenAnswer((_) async => null);

      expect(await tokenManager.hasTokens(), isFalse);
    });

    test('clearTokens deletes both tokens', () async {
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});

      await tokenManager.clearTokens();

      verify(() => mockStorage.delete(key: 'access_token')).called(1);
      verify(() => mockStorage.delete(key: 'refresh_token')).called(1);
    });
  });
}
