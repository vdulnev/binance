import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  Future<void> write({required String key, required String value});
  Future<String?> read({required String key});
  Future<void> delete({required String key});
  Future<void> deleteAll();
}

class FlutterSecureStorageService implements SecureStorageService {
  FlutterSecureStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  // macOS: disable DataProtection keychain. Without a signing team the
  // DataProtection keychain returns -34018 (errSecMissingEntitlement).
  // With this false, the plugin uses the file-based keychain.
  static const _mac = MacOsOptions(useDataProtectionKeyChain: false);

  @override
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value, mOptions: _mac);

  @override
  Future<String?> read({required String key}) =>
      _storage.read(key: key, mOptions: _mac);

  @override
  Future<void> delete({required String key}) =>
      _storage.delete(key: key, mOptions: _mac);

  @override
  Future<void> deleteAll() => _storage.deleteAll(mOptions: _mac);
}
