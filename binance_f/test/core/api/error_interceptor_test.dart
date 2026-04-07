import 'package:binance_f/core/api/error_interceptor.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ErrorInterceptor interceptor;

  DioException makeErr({
    int? status,
    Object? data,
    Map<String, List<String>>? headers,
    DioExceptionType type = DioExceptionType.badResponse,
  }) {
    final ro = RequestOptions(path: '/test');
    return DioException(
      requestOptions: ro,
      type: type,
      response: status == null
          ? null
          : Response<dynamic>(
              requestOptions: ro,
              statusCode: status,
              data: data,
              headers: headers == null ? null : Headers.fromMap(headers),
            ),
    );
  }

  AppException? capture(DioException err) {
    AppException? out;
    interceptor.onError(
      err,
      _CapturingHandler(onNext: (e) => out = e.error as AppException?),
    );
    return out;
  }

  setUp(() => interceptor = ErrorInterceptor());

  group('ErrorInterceptor mapping', () {
    test('418 with no Retry-After → IpBan, bannedUntil null', () {
      final out = capture(makeErr(status: 418));
      expect(out, isA<IpBanException>());
      expect((out! as IpBanException).bannedUntil, isNull);
    });

    test('418 with Retry-After → IpBan with bannedUntil set', () {
      final out = capture(
        makeErr(
          status: 418,
          headers: {
            'retry-after': ['120'],
          },
        ),
      );
      expect(out, isA<IpBanException>());
      expect((out! as IpBanException).bannedUntil, isNotNull);
    });

    test('429 → RateLimit with retryAfterSeconds', () {
      final out = capture(
        makeErr(
          status: 429,
          data: {'code': -1003, 'msg': 'Too many requests.'},
          headers: {
            'retry-after': ['5'],
          },
        ),
      );
      expect(out, isA<RateLimitException>());
      expect((out! as RateLimitException).retryAfterSeconds, 5);
    });

    test('-1003 with no 429 → RateLimit', () {
      final out = capture(
        makeErr(status: 400, data: {'code': -1003, 'msg': 'TOO_MANY_REQUESTS'}),
      );
      expect(out, isA<RateLimitException>());
    });

    test('401 → AuthException', () {
      final out = capture(makeErr(status: 401));
      expect(out, isA<AuthException>());
    });

    test('-1021 → ClockSkew', () {
      final out = capture(
        makeErr(status: 400, data: {'code': -1021, 'msg': 'Timestamp ahead.'}),
      );
      expect(out, isA<ClockSkewException>());
    });

    test('-1022 → InvalidSignature', () {
      final out = capture(
        makeErr(
          status: 400,
          data: {'code': -1022, 'msg': 'Invalid signature.'},
        ),
      );
      expect(out, isA<InvalidSignatureException>());
    });

    test('-2014 → AuthException', () {
      final out = capture(
        makeErr(
          status: 401,
          data: {'code': -2014, 'msg': 'API-key format invalid.'},
        ),
      );
      expect(out, isA<AuthException>());
      expect((out! as AuthException).code, -2014);
    });

    test('-2015 → AuthException', () {
      final out = capture(
        makeErr(
          status: 401,
          data: {'code': -2015, 'msg': 'Invalid API-key, IP, or perms.'},
        ),
      );
      expect(out, isA<AuthException>());
      expect((out! as AuthException).code, -2015);
    });

    test('5xx → Network(retriable: true)', () {
      final out = capture(makeErr(status: 503));
      expect(out, isA<NetworkException>());
      expect((out! as NetworkException).retriable, isTrue);
    });

    test('connection timeout → Network(retriable: false)', () {
      final out = capture(makeErr(type: DioExceptionType.connectionTimeout));
      expect(out, isA<NetworkException>());
      expect((out! as NetworkException).retriable, isFalse);
    });

    test('offline (connectionError) → Network(retriable: false)', () {
      final out = capture(makeErr(type: DioExceptionType.connectionError));
      expect(out, isA<NetworkException>());
      expect((out! as NetworkException).retriable, isFalse);
    });

    test('arbitrary Binance code → BinanceApi', () {
      final out = capture(
        makeErr(
          status: 400,
          data: {'code': -1100, 'msg': 'Illegal characters.'},
        ),
      );
      expect(out, isA<BinanceApiException>());
      expect((out! as BinanceApiException).code, -1100);
    });

    test('does not double-wrap an existing AppException', () {
      final ro = RequestOptions(path: '/x');
      final err = DioException(
        requestOptions: ro,
        error: const AppException.network(),
      );
      AppException? out;
      interceptor.onError(
        err,
        _CapturingHandler(onNext: (e) => out = e.error as AppException?),
      );
      expect(out, isA<NetworkException>());
    });
  });
}

class _CapturingHandler extends ErrorInterceptorHandler {
  _CapturingHandler({this.onNext});

  final void Function(DioException)? onNext;

  @override
  void next(DioException err) => onNext?.call(err);
}
