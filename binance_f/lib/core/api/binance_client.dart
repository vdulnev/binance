import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

import '../env/env.dart';
import '../security/secure_storage_service.dart';
import 'error_interceptor.dart';
import 'rate_limit_interceptor.dart';
import 'redacting_dio_logger.dart';
import 'retry_interceptor.dart';
import 'signing_interceptor.dart';

Dio createBinanceClient({
  required Talker talker,
  required SecureStorageService storage,
  Env? env,
}) {
  final selectedEnv = env ?? Env.current;
  final dio = Dio(
    BaseOptions(
      baseUrl: selectedEnv.restBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Order matters. Dio runs request interceptors top-to-bottom and error
  // interceptors top-to-bottom too — so RetryInterceptor sits AFTER
  // ErrorInterceptor in the chain in order to see the wrapped AppException
  // (cleaner switch over typed cases than re-inspecting status codes).
  //   1. Signing — sign + lazy time sync, owns -1021 one-shot retry
  //   2. RateLimit — observe X-MBX-USED-WEIGHT headers
  //   3. Error — DioException → AppException
  //   4. Retry  — typed retry policy (5xx + 429 GET only)
  //   5. Logger — last so it never sees secrets
  dio.interceptors.addAll([
    SigningInterceptor(storage: storage),
    RateLimitInterceptor(talker: talker),
    ErrorInterceptor(),
    RetryInterceptor(talker: talker),
    RedactingDioLogger(talker: talker),
  ]);

  talker.info(
    'Binance REST client initialized — env=${selectedEnv.env.name}, '
    'base=${selectedEnv.restBaseUrl}',
  );

  return dio;
}
