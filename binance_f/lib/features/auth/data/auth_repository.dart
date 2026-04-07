import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/models/app_exception.dart';

abstract class AuthRepository {
  /// Verifies API credentials by calling a signed account endpoint
  /// (`GET /api/v3/account`). Returns `Right(unit)` on success and
  /// `Left(AppException)` on any failure.
  TaskEither<AppException, Unit> verifyCredentials();
}

class BinanceAuthRepository implements AuthRepository {
  BinanceAuthRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  TaskEither<AppException, Unit> verifyCredentials() => TaskEither.tryCatch(
    () async {
      // GET /api/v3/account is a SIGNED (USER_DATA) endpoint.
      // The SigningInterceptor adds the API key header, timestamp,
      // and HMAC-SHA256 signature automatically.
      await _dio.get<Map<String, dynamic>>('/api/v3/account');
      return unit;
    },
    (err, _) {
      // ErrorInterceptor wraps DioException.error as AppException.
      // Anything else (e.g. parser failure) becomes Unknown.
      if (err is AppException) return err;
      if (err is DioException && err.error is AppException) {
        return err.error! as AppException;
      }
      return AppException.unknown(message: err.toString());
    },
  );
}
