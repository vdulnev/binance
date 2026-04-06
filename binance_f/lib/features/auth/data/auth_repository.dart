import 'package:dio/dio.dart';

abstract class AuthRepository {
  /// Verifies API credentials by calling a signed account endpoint.
  /// Throws [DioException] if credentials are invalid.
  Future<void> verifyCredentials();
}

class BinanceAuthRepository implements AuthRepository {
  BinanceAuthRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> verifyCredentials() async {
    // GET /api/v3/account is a SIGNED (USER_DATA) endpoint.
    // The SigningInterceptor adds the API key header, timestamp,
    // and HMAC-SHA256 signature automatically.
    await _dio.get<Map<String, dynamic>>('/api/v3/account');
  }
}
