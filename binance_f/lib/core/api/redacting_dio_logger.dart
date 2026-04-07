import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

/// Logs Dio traffic via Talker with sensitive values redacted before they
/// reach any log sink. Specifically:
///   * `X-MBX-APIKEY` header is replaced with `***`
///   * `signature` query param is replaced with `***`
///   * `apiKey` / `api_key` / `secret` / `apiSecret` keys in request bodies
///     and query params are replaced with `***`
///
/// Per FR-11.2: API secrets, signatures, and full API keys must never appear
/// in logs.
class RedactingDioLogger extends Interceptor {
  RedactingDioLogger({required Talker talker}) : _talker = talker;

  final Talker _talker;

  static const _redacted = '***';
  static const _sensitiveQueryKeys = {
    'signature',
    'apikey',
    'api_key',
    'secret',
    'apisecret',
    'api_secret',
  };
  static const _sensitiveHeaderKeys = {'x-mbx-apikey'};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method;
    final uri = _redactUri(options.uri);
    _talker.debug('HTTP → $method $uri');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final method = response.requestOptions.method;
    final uri = _redactUri(response.requestOptions.uri);
    _talker.debug('HTTP ← ${response.statusCode} $method $uri');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final method = err.requestOptions.method;
    final uri = _redactUri(err.requestOptions.uri);
    _talker.error(
      'HTTP ✗ ${err.response?.statusCode ?? '-'} $method $uri',
      err.error,
    );
    handler.next(err);
  }

  Uri _redactUri(Uri uri) {
    if (uri.queryParameters.isEmpty) return uri;
    final cleaned = <String, String>{};
    uri.queryParameters.forEach((k, v) {
      cleaned[k] = _sensitiveQueryKeys.contains(k.toLowerCase())
          ? _redacted
          : v;
    });
    return uri.replace(queryParameters: cleaned);
  }

  /// Exposed for tests / debugging.
  static Map<String, String> redactHeaders(Map<String, dynamic> headers) {
    final result = <String, String>{};
    headers.forEach((k, v) {
      result[k] = _sensitiveHeaderKeys.contains(k.toLowerCase())
          ? _redacted
          : v.toString();
    });
    return result;
  }
}
