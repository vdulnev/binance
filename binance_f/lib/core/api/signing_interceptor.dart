import 'package:dio/dio.dart';

import '../security/crypto_utils.dart';
import '../security/secure_storage_service.dart';

const _kApiKey = 'binance_api_key';
const _kApiSecret = 'binance_api_secret';

class SigningInterceptor extends Interceptor {
  SigningInterceptor({required SecureStorageService storage})
    : _storage = storage;

  final SecureStorageService _storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final apiKey = await _storage.read(key: _kApiKey);
    final apiSecret = await _storage.read(key: _kApiSecret);

    if (apiKey == null || apiSecret == null) {
      handler.next(options);
      return;
    }

    options.headers['X-MBX-APIKEY'] = apiKey;

    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    options.queryParameters['timestamp'] = timestamp;

    final queryString = options.queryParameters.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');

    final signature = hmacSha256Sign(data: queryString, secret: apiSecret);
    options.queryParameters['signature'] = signature;

    handler.next(options);
  }
}
