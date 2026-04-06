import 'package:dio/dio.dart';

import '../security/crypto_utils.dart';
import '../security/secure_storage_service.dart';

const _kApiKey = 'binance_api_key';
const _kApiSecret = 'binance_api_secret';

class SigningInterceptor extends Interceptor {
  SigningInterceptor({required SecureStorageService storage})
    : _storage = storage;

  final SecureStorageService _storage;

  /// Offset in milliseconds: serverTime - localTime.
  int _timeOffset = 0;
  bool _timeSynced = false;

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

    if (!_timeSynced) {
      await _syncTime(options.baseUrl);
    }

    options.headers['X-MBX-APIKEY'] = apiKey;

    final timestamp = DateTime.now().millisecondsSinceEpoch + _timeOffset;
    options.queryParameters['timestamp'] = timestamp.toString();

    final queryString = options.queryParameters.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');

    final signature = hmacSha256Sign(data: queryString, secret: apiSecret);
    options.queryParameters['signature'] = signature;

    handler.next(options);
  }

  Future<void> _syncTime(String baseUrl) async {
    try {
      final dio = Dio(BaseOptions(baseUrl: baseUrl));
      final localBefore = DateTime.now().millisecondsSinceEpoch;
      final response = await dio.get<Map<String, dynamic>>('/api/v3/time');
      final localAfter = DateTime.now().millisecondsSinceEpoch;
      final serverTime = response.data!['serverTime'] as int;
      final localTime = (localBefore + localAfter) ~/ 2;
      _timeOffset = serverTime - localTime;
      _timeSynced = true;
    } on DioException {
      // If sync fails, proceed with local time.
      _timeSynced = true;
    }
  }
}
