import 'package:dio/dio.dart';

import '../models/app_exception.dart';

/// Maps every Dio failure to an [AppException]. Downstream code (repositories,
/// providers, UI) should never have to inspect a [DioException] directly.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // If a previous interceptor has already wrapped the error, leave it alone.
    if (err.error is AppException) {
      handler.next(err);
      return;
    }

    final mapped = _map(err);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: mapped,
        stackTrace: err.stackTrace,
      ),
    );
  }

  AppException _map(DioException err) {
    // Connection / timeout / TLS / cancel — no HTTP response.
    if (err.response == null) {
      switch (err.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const AppException.network(message: 'Connection timed out.');
        case DioExceptionType.connectionError:
          return const AppException.network(
            message: 'Could not reach Binance.',
          );
        case DioExceptionType.badCertificate:
          return const AppException.network(message: 'TLS handshake failed.');
        case DioExceptionType.cancel:
          return const AppException.network(message: 'Request cancelled.');
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          return AppException.network(message: err.message);
      }
    }

    final response = err.response!;
    final status = response.statusCode;
    final data = response.data;

    // Binance error envelope: { "code": <int>, "msg": <string> }
    int? binanceCode;
    String? binanceMsg;
    if (data is Map<String, dynamic> &&
        data['code'] is int &&
        data['msg'] is String) {
      binanceCode = data['code'] as int;
      binanceMsg = data['msg'] as String;
    }

    // 418 IP ban — hard-stop, surface remaining ban time if available.
    if (status == 418) {
      final retryAfter = _parseRetryAfter(response);
      return AppException.ipBan(
        message: binanceMsg ?? 'IP temporarily banned by Binance.',
        bannedUntil: retryAfter == null
            ? null
            : DateTime.now().add(Duration(seconds: retryAfter)),
      );
    }

    // 429 / -1003 — rate limit (NOT a ban).
    if (status == 429 || binanceCode == -1003) {
      return AppException.rateLimit(
        message: binanceMsg ?? 'Rate limit exceeded.',
        retryAfterSeconds: _parseRetryAfter(response),
        code: binanceCode,
      );
    }

    // Map known Binance codes.
    switch (binanceCode) {
      case -1021:
        return AppException.clockSkew(message: binanceMsg);
      case -1022:
        return AppException.invalidSignature(message: binanceMsg);
      case -2014:
      case -2015:
        return AppException.auth(
          message: binanceMsg ?? 'API key invalid or lacks permissions.',
          code: binanceCode,
        );
    }

    // 401 with no Binance envelope.
    if (status == 401) {
      return AppException.auth(
        message: binanceMsg ?? 'Unauthorized.',
        code: binanceCode,
      );
    }

    // 5xx — Binance outage, retriable.
    if (status != null && status >= 500 && status < 600) {
      return AppException.network(
        message: binanceMsg ?? 'Binance is having trouble (HTTP $status).',
        retriable: true,
      );
    }

    if (binanceCode != null && binanceMsg != null) {
      return AppException.binanceApi(
        code: binanceCode,
        message: binanceMsg,
        httpStatusCode: status,
      );
    }

    return AppException.unknown(
      message: 'HTTP $status${binanceMsg != null ? ' — $binanceMsg' : ''}',
    );
  }

  /// Parses the `Retry-After` header. Binance sends seconds as an integer.
  int? _parseRetryAfter(Response<dynamic> response) {
    final header = response.headers.value('retry-after');
    if (header == null) return null;
    return int.tryParse(header.trim());
  }
}
