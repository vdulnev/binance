import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

import '../env/env.dart';
import '../env/env_manager.dart';
import 'error_interceptor.dart';
import 'rate_limit_interceptor.dart';
import 'redacting_dio_logger.dart';
import 'retry_interceptor.dart';
import 'signing_interceptor.dart';

/// Builds a Dio instance pointed at the [env]'s base URL for [market],
/// wired with the standard interceptor chain.
///
/// The [signing] interceptor is shared across spot + futures so the lazy
/// `/api/v3/time` offset is computed once. The other interceptors are
/// cheap and built per-instance so they keep their own per-Dio state
/// (rate-limit counters, retry attempt extras, etc.).
Dio createBinanceClient({
  required Env env,
  required BinanceMarket market,
  required SigningInterceptor signing,
  required Talker talker,
}) {
  final baseUrl = market == BinanceMarket.futures
      ? env.futuresRestBaseUrl
      : env.restBaseUrl;

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Order matters. Dio runs request interceptors top-to-bottom and error
  // interceptors top-to-bottom too — so RetryInterceptor sits AFTER
  // ErrorInterceptor in the chain in order to see the wrapped AppException
  // (cleaner switch over typed cases than re-inspecting status codes).
  //   1. Signing — sign + lazy time sync, owns -1021 one-shot retry
  //                (shared across spot + futures)
  //   2. RateLimit — observe X-MBX-USED-WEIGHT headers
  //   3. Error — DioException → AppException
  //   4. Retry  — typed retry policy (5xx + 429 GET only)
  //   5. Logger — last so it never sees secrets
  dio.interceptors.addAll([
    signing,
    RateLimitInterceptor(talker: talker),
    ErrorInterceptor(),
    RetryInterceptor(talker: talker),
    RedactingDioLogger(talker: talker),
  ]);

  talker.info(
    'Binance ${market.name} client initialized — env=${env.env.name}, '
    'base=$baseUrl',
  );

  return dio;
}
