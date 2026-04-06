import '../security/secure_storage_service.dart';

const kApiKey = 'binance_api_key';
const kApiSecret = 'binance_api_secret';

class CredentialsManager {
  CredentialsManager({required SecureStorageService storage})
    : _storage = storage;

  final SecureStorageService _storage;

  Future<void> saveCredentials({
    required String apiKey,
    required String apiSecret,
  }) async {
    await Future.wait([
      _storage.write(key: kApiKey, value: apiKey),
      _storage.write(key: kApiSecret, value: apiSecret),
    ]);
  }

  Future<String?> getApiKey() => _storage.read(key: kApiKey);

  Future<String?> getApiSecret() => _storage.read(key: kApiSecret);

  Future<bool> hasCredentials() async {
    final key = await _storage.read(key: kApiKey);
    final secret = await _storage.read(key: kApiSecret);
    return key != null && secret != null;
  }

  Future<void> clearCredentials() async {
    await Future.wait([
      _storage.delete(key: kApiKey),
      _storage.delete(key: kApiSecret),
    ]);
  }
}
