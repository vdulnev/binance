import 'package:binance_f/core/api/rate_limit_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker/talker.dart';

class MockTalker extends Mock implements Talker {}

void main() {
  late MockTalker talker;
  late RateLimitInterceptor interceptor;

  setUp(() {
    talker = MockTalker();
    interceptor = RateLimitInterceptor(talker: talker);
  });

  Response _makeResponse(String? weight) {
    final headers = Headers();
    if (weight != null) {
      headers.set('X-MBX-USED-WEIGHT-1M', weight);
    }
    return Response(
      requestOptions: RequestOptions(path: '/test'),
      headers: headers,
      statusCode: 200,
    );
  }

  group('RateLimitInterceptor', () {
    test('logs warning when weight > 900', () {
      final response = _makeResponse('901');
      final handler = ResponseInterceptorHandler();
      
      interceptor.onResponse(response, handler);
      
      verify(() => talker.warning(any(that: contains('901/1200')))).called(1);
    });

    test('does NOT log warning when weight <= 900', () {
      final response = _makeResponse('900');
      final handler = ResponseInterceptorHandler();
      
      interceptor.onResponse(response, handler);
      
      verifyNever(() => talker.warning(any()));
    });

    test('does NOT log warning when header is missing', () {
      final response = _makeResponse(null);
      final handler = ResponseInterceptorHandler();
      
      interceptor.onResponse(response, handler);
      
      verifyNever(() => talker.warning(any()));
    });

    test('does NOT log warning when weight is invalid', () {
      final response = _makeResponse('not-a-number');
      final handler = ResponseInterceptorHandler();
      
      interceptor.onResponse(response, handler);
      
      verifyNever(() => talker.warning(any()));
    });
  });
}
