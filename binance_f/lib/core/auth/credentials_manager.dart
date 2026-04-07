import 'package:fpdart/fpdart.dart';

import '../models/app_exception.dart';
import '../security/secure_storage_service.dart';

const kApiKey = 'binance_api_key';
const kApiSecret = 'binance_api_secret';

/// Wraps [SecureStorageService] in `TaskEither`s so it composes cleanly with
/// the rest of the auth chain. The underlying secure storage plugin still
/// throws (it's the OS boundary); we map any failure here into
/// [AppException.unknown] so callers never need a `try` block.
class CredentialsManager {
  CredentialsManager({required SecureStorageService storage})
    : _storage = storage;

  final SecureStorageService _storage;

  TaskEither<AppException, Unit> saveCredentials({
    required String apiKey,
    required String apiSecret,
  }) => TaskEither.tryCatch(() async {
    await Future.wait([
      _storage.write(key: kApiKey, value: apiKey),
      _storage.write(key: kApiSecret, value: apiSecret),
    ]);
    return unit;
  }, _toAppException);

  TaskEither<AppException, String?> getApiKey() =>
      TaskEither.tryCatch(() => _storage.read(key: kApiKey), _toAppException);

  TaskEither<AppException, String?> getApiSecret() => TaskEither.tryCatch(
    () => _storage.read(key: kApiSecret),
    _toAppException,
  );

  TaskEither<AppException, bool> hasCredentials() =>
      TaskEither.tryCatch(() async {
        final key = await _storage.read(key: kApiKey);
        final secret = await _storage.read(key: kApiSecret);
        return key != null && secret != null;
      }, _toAppException);

  TaskEither<AppException, Unit> clearCredentials() =>
      TaskEither.tryCatch(() async {
        await Future.wait([
          _storage.delete(key: kApiKey),
          _storage.delete(key: kApiSecret),
        ]);
        return unit;
      }, _toAppException);
}

AppException _toAppException(Object err, StackTrace _) =>
    err is AppException ? err : AppException.unknown(message: err.toString());
