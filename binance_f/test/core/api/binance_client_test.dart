import 'package:binance_f/core/api/binance_client.dart';
import 'package:binance_f/core/api/error_interceptor.dart';
import 'package:binance_f/core/api/rate_limit_interceptor.dart';
import 'package:binance_f/core/api/redacting_dio_logger.dart';
import 'package:binance_f/core/api/retry_interceptor.dart';
import 'package:binance_f/core/api/signing_interceptor.dart';
import 'package:binance_f/core/env/env.dart';
import 'package:binance_f/core/env/env_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker/talker.dart';

class MockEnv extends Mock implements Env {}

class MockSigningInterceptor extends Mock implements SigningInterceptor {}

class MockTalker extends Mock implements Talker {}

void main() {
  late MockEnv env;
  late MockSigningInterceptor signing;
  late MockTalker talker;

  setUp(() {
    env = MockEnv();
    signing = MockSigningInterceptor();
    talker = MockTalker();

    when(() => env.restBaseUrl).thenReturn('https://api.binance.com');
    when(() => env.futuresRestBaseUrl).thenReturn('https://fapi.binance.com');
    when(() => env.env).thenReturn(BinanceEnv.mainnet);
  });

  group('createBinanceClient', () {
    test('creates spot client with correct baseUrl and interceptors', () {
      final dio = createBinanceClient(
        env: env,
        market: BinanceMarket.spot,
        signing: signing,
        talker: talker,
      );

      expect(dio.options.baseUrl, 'https://api.binance.com');

      final interceptors = dio.interceptors;
      expect(interceptors, anyElement(isA<MockSigningInterceptor>()));
      expect(interceptors, anyElement(isA<RateLimitInterceptor>()));
      expect(interceptors, anyElement(isA<ErrorInterceptor>()));
      expect(interceptors, anyElement(isA<RetryInterceptor>()));
      expect(interceptors, anyElement(isA<RedactingDioLogger>()));

      verify(
        () => talker.info(any(that: contains('spot client initialized'))),
      ).called(1);
    });

    test('creates futures client with correct baseUrl', () {
      final dio = createBinanceClient(
        env: env,
        market: BinanceMarket.futures,
        signing: signing,
        talker: talker,
      );

      expect(dio.options.baseUrl, 'https://fapi.binance.com');
      verify(
        () => talker.info(any(that: contains('futures client initialized'))),
      ).called(1);
    });
  });
}
