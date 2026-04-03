import 'package:dio/dio.dart';

import 'models/auth_response.dart';
import 'models/login_request.dart';
import 'models/two_factor_request.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> verifyTwoFactor(TwoFactorRequest request);
  Future<void> logout(String accessToken);
  Future<AuthResponse> refreshToken(String refreshToken);
}

class BinanceAuthRepository implements AuthRepository {
  BinanceAuthRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    // TODO: confirm actual Binance auth endpoint
    final response = await _dio.post<Map<String, dynamic>>(
      '/sapi/v1/account/login',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data!);
  }

  @override
  Future<AuthResponse> verifyTwoFactor(TwoFactorRequest request) async {
    // TODO: confirm actual Binance 2FA endpoint
    final response = await _dio.post<Map<String, dynamic>>(
      '/sapi/v1/account/verify-2fa',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data!);
  }

  @override
  Future<void> logout(String accessToken) async {
    // TODO: confirm actual Binance logout/revoke endpoint
    await _dio.post<void>(
      '/sapi/v1/account/logout',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    // TODO: confirm actual Binance token refresh endpoint
    final response = await _dio.post<Map<String, dynamic>>(
      '/sapi/v1/account/token/refresh',
      data: {'refreshToken': refreshToken},
    );
    return AuthResponse.fromJson(response.data!);
  }
}
