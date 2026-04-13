import 'package:binance_f/core/api/redacting_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';

class FakeTalker extends Talker {
  String? lastDebug;
  String? lastError;

  @override
  void debug(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    lastDebug = msg.toString();
  }

  @override
  void error(dynamic msg, [Object? exception, StackTrace? stackTrace]) {
    lastError = msg.toString();
  }
}

class FakeErrorInterceptorHandler extends ErrorInterceptorHandler {
  @override
  void next(DioException err) {}
}

class FakeRequestInterceptorHandler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions options) {}
}

class FakeResponseInterceptorHandler extends ResponseInterceptorHandler {
  @override
  void next(Response response) {}
}

void main() {
  late FakeTalker talker;
  late RedactingDioLogger logger;

  setUp(() {
    talker = FakeTalker();
    logger = RedactingDioLogger(talker: talker);
  });

  group('RedactingDioLogger', () {
    test('redacts sensitive query parameters and headers in onRequest', () {
      final options = RequestOptions(
        path: '/api/v3/order',
        baseUrl: 'https://api.binance.com',
        queryParameters: {
          'symbol': 'BTCUSDT',
          'signature': 'very-secret-signature',
          'apiKey': 'my-api-key',
        },
        headers: {
          'X-MBX-APIKEY': 'secret-key',
          'Content-Type': 'application/json',
        },
      );
      
      logger.onRequest(options, FakeRequestInterceptorHandler());
      
      expect(talker.lastDebug, contains('signature=%2A%2A%2A'));
      expect(talker.lastDebug, contains('symbol=BTCUSDT'));
      expect(talker.lastDebug, contains('X-MBX-APIKEY: ***'));
      expect(talker.lastDebug, contains('Content-Type: application/json'));
    });

    test('redacts sensitive query parameters and headers in onResponse', () {
      final response = Response(
        requestOptions: RequestOptions(
          path: '/api/v3/account',
          queryParameters: {'signature': 'secret'},
          headers: {'X-MBX-APIKEY': 'secret-key'},
        ),
        headers: Headers.fromMap({
          'X-MBX-APIKEY': ['secret-key'],
        }),
        statusCode: 200,
      );
      
      logger.onResponse(response, FakeResponseInterceptorHandler());
      
      expect(talker.lastDebug, contains('signature=%2A%2A%2A'));
      expect(talker.lastDebug, contains('X-MBX-APIKEY: ***'));
    });

    test('redacts sensitive query parameters and headers in onError', () {
      final err = DioException(
        requestOptions: RequestOptions(
          path: '/api/v3/order',
          queryParameters: {'signature': 'secret'},
          headers: {'X-MBX-APIKEY': 'secret-key'},
        ),
        type: DioExceptionType.badResponse,
        error: 'Some error',
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 400,
        ),
      );
      
      logger.onError(err, FakeErrorInterceptorHandler());
      
      expect(talker.lastError, contains('signature=%2A%2A%2A'));
      expect(talker.lastError, contains('X-MBX-APIKEY: ***'));
    });

    test('redactHeaders static method works', () {
      final headers = {
        'X-MBX-APIKEY': 'secret-key',
        'Content-Type': 'application/json',
      };
      
      final redacted = RedactingDioLogger.redactHeaders(headers);
      
      expect(redacted['X-MBX-APIKEY'], '***');
      expect(redacted['Content-Type'], 'application/json');
    });
  });
}
