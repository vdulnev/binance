import 'package:fpdart/fpdart.dart';

import '../env/env.dart';
import '../models/app_exception.dart';
import '../security/secure_storage_service.dart';

const kApiKey = 'binance_api_key';
const kApiSecret = 'binance_api_secret';
const kEnv = 'binance_env';

/// Wraps [SecureStorageService] in `TaskEither`s so it composes cleanly with
/// the rest of the auth chain. The underlying secure storage plugin still
/// throws (it's the OS boundary); we map any failure here into
/// [AppException.unknown] so callers never need a `try` block.
class CredentialsManager {
  CredentialsManager({required SecureStorageService storage})
    : _storage = storage;

  final SecureStorageService _storage;

  /// Persists API key, secret, and selected environment in a single atomic
  /// `Future.wait`. The env is written alongside the credentials so the
  /// next launch can restore the same host before the auth guard runs.
  TaskEither<AppException, Unit> saveCredentials({
    required String apiKey,
    required String apiSecret,
    required BinanceEnv env,
  }) => TaskEither.tryCatch(() async {
    await Future.wait([
      _storage.write(key: kApiKey, value: apiKey),
      _storage.write(key: kApiSecret, value: apiSecret),
      _storage.write(key: kEnv, value: env.name),
    ]);
    return unit;
  }, _toAppException);

  TaskEither<AppException, String?> getApiKey() =>
      TaskEither.tryCatch(() => _storage.read(key: kApiKey), _toAppException);

  TaskEither<AppException, String?> getApiSecret() => TaskEither.tryCatch(
    () => _storage.read(key: kApiSecret),
    _toAppException,
  );

  /// Reads the persisted env. Returns `Right(null)` when nothing has been
  /// stored yet (first run / post-logout) and `Left(unknown)` when the
  /// stored value can't be parsed back into a [BinanceEnv].
  TaskEither<AppException, BinanceEnv?> getEnv() =>
      TaskEither.tryCatch(() async {
        final raw = await _storage.read(key: kEnv);
        if (raw == null) return null;
        final lower = raw.toLowerCase();
        for (final value in BinanceEnv.values) {
          if (value.name == lower) return value;
        }
        throw AppException.unknown(
          message: 'Unrecognized binance_env value: "$raw".',
        );
      }, _toAppException);

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
          _storage.delete(key: kEnv),
        ]);
        return unit;
      }, _toAppException);
}

AppException _toAppException(Object err, StackTrace _) =>
    err is AppException ? err : AppException.unknown(message: err.toString());
