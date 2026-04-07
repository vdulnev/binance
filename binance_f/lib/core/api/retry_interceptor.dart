import 'dart:async';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

import '../models/app_exception.dart';

const _kRetryAttemptsKey = '__binance_retry_attempts__';

/// Retries transient failures. Runs AFTER [ErrorInterceptor] so that the
/// `err.error` field is already wrapped in [AppException] — this gives us a
/// single, typed retry policy table instead of inspecting raw status codes.
///
/// Policy (per spec §7.4 + EC-9):
/// - `Network(retriable: true)` (5xx): exponential backoff, max 2 retries,
///   500ms → 4s cap. Skips non-idempotent verbs (POST/DELETE) since
///   trade reconciliation lives in trade repositories.
/// - `RateLimit` with `retryAfterSeconds`: wait the header value, retry once,
///   GET only.
/// - Anything else: pass through.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required Talker talker,
    this.maxNetworkRetries = 2,
    this.initialBackoff = const Duration(milliseconds: 500),
    this.maxBackoff = const Duration(seconds: 4),
    Future<void> Function(Duration)? sleep,
  }) : _talker = talker,
       _sleep = sleep ?? Future<void>.delayed;

  final Talker _talker;
  final int maxNetworkRetries;
  final Duration initialBackoff;
  final Duration maxBackoff;
  final Future<void> Function(Duration) _sleep;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final wrapped = err.error;
    if (wrapped is! AppException) {
      handler.next(err);
      return;
    }

    final method = err.requestOptions.method.toUpperCase();
    final attempts =
        (err.requestOptions.extra[_kRetryAttemptsKey] as int?) ?? 0;

    Duration? wait;
    int newAttempts = attempts;

    switch (wrapped) {
      case NetworkException(retriable: true):
        if (method != 'GET' && method != 'PUT') {
          handler.next(err);
          return;
        }
        if (attempts >= maxNetworkRetries) {
          handler.next(err);
          return;
        }
        final backoffMs = math.min(
          maxBackoff.inMilliseconds,
          initialBackoff.inMilliseconds * (1 << attempts),
        );
        wait = Duration(milliseconds: backoffMs);
        newAttempts = attempts + 1;
        _talker.warning(
          'Retrying ${err.requestOptions.path} after ${wait.inMilliseconds}ms '
          '(attempt $newAttempts/$maxNetworkRetries) — ${wrapped.message}',
        );

      case RateLimitException(:final retryAfterSeconds):
        if (method != 'GET' || retryAfterSeconds == null || attempts >= 1) {
          handler.next(err);
          return;
        }
        wait = Duration(seconds: retryAfterSeconds);
        newAttempts = 1;
        _talker.warning(
          'Rate limited. Waiting ${retryAfterSeconds}s then retrying '
          '${err.requestOptions.path}',
        );

      default:
        handler.next(err);
        return;
    }

    await _sleep(wait);

    final retryOptions = err.requestOptions
      ..extra[_kRetryAttemptsKey] = newAttempts;

    try {
      // Use a fresh Dio so we don't recurse through this interceptor chain.
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
      handler.next(retryErr);
    }
  }
}
