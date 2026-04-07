import 'package:dio/dio.dart';

import '../../../core/models/app_exception.dart';

abstract class AuthRepository {
  /// Verifies API credentials by calling a signed account endpoint
  /// (`GET /api/v3/account`). Throws an [AppException] on any failure.
  Future<void> verifyCredentials();
}

class BinanceAuthRepository implements AuthRepository {
  BinanceAuthRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> verifyCredentials() async {
    try {
      // GET /api/v3/account is a SIGNED (USER_DATA) endpoint.
      // The SigningInterceptor adds the API key header, timestamp,
      // and HMAC-SHA256 signature automatically.
      await _dio.get<Map<String, dynamic>>('/api/v3/account');
    } on DioException catch (e) {
      // ErrorInterceptor wraps everything as AppException; re-throw it.
      final wrapped = e.error;
      if (wrapped is AppException) throw wrapped;
      throw AppException.unknown(message: e.message);
    }
  }
}
