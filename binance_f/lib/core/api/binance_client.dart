import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../security/secure_storage_service.dart';
import 'error_interceptor.dart';
import 'rate_limit_interceptor.dart';
import 'signing_interceptor.dart';

const _baseUrl = 'https://api.binance.com';

Dio createBinanceClient({
  required Talker talker,
  required SecureStorageService storage,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.addAll([
    SigningInterceptor(storage: storage),
    RateLimitInterceptor(talker: talker),
    ErrorInterceptor(),
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: false,
      ),
    ),
  ]);

  return dio;
}
