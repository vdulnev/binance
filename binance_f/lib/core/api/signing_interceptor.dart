import 'package:dio/dio.dart';

import '../models/app_exception.dart';
import '../security/crypto_utils.dart';
import '../security/secure_storage_service.dart';

const _kApiKey = 'binance_api_key';
const _kApiSecret = 'binance_api_secret';
const _kRetryFlag = '__binance_signing_retried__';

/// Signs Binance USER_DATA / TRADE / USER_STREAM requests with HMAC-SHA256,
/// attaches the `X-MBX-APIKEY` header, and adds a `timestamp` synchronized to
/// Binance server time. On `-1021` clock-skew errors, invalidates the offset
/// and retries the request exactly once.
///
/// Public (NONE-security) endpoints are passed through unsigned.
class SigningInterceptor extends Interceptor {
  SigningInterceptor({
    required SecureStorageService storage,
    Dio? timeSyncClient,
  }) : _storage = storage,
       _timeSyncClient = timeSyncClient;

  final SecureStorageService _storage;
  final Dio? _timeSyncClient;

  /// Offset (ms): serverTime - localTime.
  int _timeOffset = 0;
  bool _timeSynced = false;

  /// Paths that require signing (USER_DATA, TRADE, USER_STREAM).
  /// Everything else is NONE-security and must not be signed.
  static const _signedPaths = <String>{
    // Spot USER_DATA
    '/api/v3/account',
    '/api/v3/openOrders',
    '/api/v3/allOrders',
    '/api/v3/myTrades',
    // Spot TRADE
    '/api/v3/order',
    '/api/v3/order/oco',
    '/api/v3/order/test',
    // Spot USER_STREAM
    '/api/v3/userDataStream',
    // Futures USER_DATA
    '/fapi/v2/account',
    '/fapi/v1/allOrders',
    '/fapi/v1/openOrders',
    '/fapi/v1/userTrades',
    '/fapi/v1/positionRisk',
    // Futures TRADE
    '/fapi/v1/order',
    '/fapi/v1/allOpenOrders',
    // Futures USER_STREAM
    '/fapi/v1/listenKey',
    // Capital (SAPI)
    '/sapi/v1/capital/deposit/hisrec',
    '/sapi/v1/capital/withdraw/history',
    '/sapi/v1/capital/deposit/address',
  };

  /// Returns true when the request path matches a signed endpoint.
  bool _requiresSigning(String path) => _signedPaths.contains(path);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_requiresSigning(options.path)) {
      // Public (NONE-security) endpoint — pass through without any signing
      // headers. Do NOT attach X-MBX-APIKEY here: some Binance endpoints
      // interpret its presence as intent to sign and then reject for missing
      // signature (-1102).
      handler.next(options);
      return;
    }

    final apiKey = await _storage.read(key: _kApiKey);
    final apiSecret = await _storage.read(key: _kApiSecret);

    if (apiKey == null || apiSecret == null) {
      // Signed endpoint but no credentials (e.g. post-logout rebuild).
      // Reject immediately — sending unsigned would trigger -1102.
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          error: const AppException.auth(message: 'Not authenticated.'),
        ),
      );
      return;
    }

    if (!_timeSynced) {
      await _syncTime(options.baseUrl);
    }

    _signInPlace(options, apiKey: apiKey, apiSecret: apiSecret);
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isClockSkew = err.error is ClockSkewException;
    if (!isClockSkew) {
      handler.next(err);
      return;
    }
    if (err.requestOptions.extra[_kRetryFlag] == true) {
      handler.next(err);
      return;
    }

    // Re-sync once and retry the request.
    _timeSynced = false;
    await _syncTime(err.requestOptions.baseUrl);

    final apiKey = await _storage.read(key: _kApiKey);
    final apiSecret = await _storage.read(key: _kApiSecret);
    if (apiKey == null || apiSecret == null) {
      handler.next(err);
      return;
    }

    final retryOptions = err.requestOptions
      ..extra[_kRetryFlag] = true
      // Drop previous timestamp/signature so they get recomputed.
      ..queryParameters.remove('timestamp')
      ..queryParameters.remove('signature');

    _signInPlace(retryOptions, apiKey: apiKey, apiSecret: apiSecret);

    try {
      // Use a fresh Dio so we don't recurse through this interceptor.
      final retryDio = Dio(
        BaseOptions(
          baseUrl: retryOptions.baseUrl,
          connectTimeout: retryOptions.connectTimeout,
          receiveTimeout: retryOptions.receiveTimeout,
        ),
      );
      final response = await retryDio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } on DioException catch (retryErr) {
      // If the retry also failed clock-skew style, surface as ClockSkew so
      // the UI gets a clear "fix your device clock" message instead of a
      // generic Binance envelope.
      handler.next(
        DioException(
          requestOptions: retryErr.requestOptions,
          response: retryErr.response,
          type: retryErr.type,
          stackTrace: retryErr.stackTrace,
          error: const AppException.clockSkew(
            message: 'Clock still out of sync after re-syncing with Binance.',
          ),
        ),
      );
    }
  }

  void _signInPlace(
    RequestOptions options, {
    required String apiKey,
    required String apiSecret,
  }) {
    options.headers['X-MBX-APIKEY'] = apiKey;

    final timestamp = DateTime.now().millisecondsSinceEpoch + _timeOffset;
    options.queryParameters['timestamp'] = timestamp;

    final queryString = options.queryParameters.entries
        .map(
          (e) =>
              '${Uri.encodeQueryComponent(e.key)}'
              '=${Uri.encodeQueryComponent(e.value.toString())}',
        )
        .join('&');

    final signature = hmacSha256Sign(data: queryString, secret: apiSecret);
    options.queryParameters['signature'] = signature;
  }

  Future<void> _syncTime(String baseUrl) async {
    try {
      final dio = _timeSyncClient ?? Dio(BaseOptions(baseUrl: baseUrl));
      final localBefore = DateTime.now().millisecondsSinceEpoch;
      final response = await dio.get<Map<String, dynamic>>('/api/v3/time');
      final localAfter = DateTime.now().millisecondsSinceEpoch;
      final serverTime = response.data?['serverTime'] as int?;
      if (serverTime == null) {
        // Response body missing or malformed — fall back to local clock.
        _timeSynced = true;
        return;
      }
      final localTime = (localBefore + localAfter) ~/ 2;
      _timeOffset = serverTime - localTime;
      _timeSynced = true;
    } on DioException {
      // Sync failed — fall back to local clock for this attempt.
      _timeSynced = true;
    }
  }
}
