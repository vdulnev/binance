import '../security/secure_storage_service.dart';

const _kAccessToken = 'access_token';
const _kRefreshToken = 'refresh_token';

class TokenManager {
  TokenManager({required SecureStorageService storage}) : _storage = storage;

  final SecureStorageService _storage;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: _kAccessToken, value: accessToken),
      _storage.write(key: _kRefreshToken, value: refreshToken),
    ]);
  }

  Future<String?> getAccessToken() => _storage.read(key: _kAccessToken);

  Future<String?> getRefreshToken() => _storage.read(key: _kRefreshToken);

  Future<bool> hasTokens() async {
    final token = await _storage.read(key: _kAccessToken);
    return token != null;
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _kAccessToken),
      _storage.delete(key: _kRefreshToken),
    ]);
  }
}
