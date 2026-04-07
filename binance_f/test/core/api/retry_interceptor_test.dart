import 'package:binance_f/core/api/retry_interceptor.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';

void main() {
  late RetryInterceptor interceptor;
  late List<Duration> sleeps;

  setUp(() {
    sleeps = [];
    interceptor = RetryInterceptor(
      talker: Talker(),
      sleep: (d) async => sleeps.add(d),
    );
  });

  DioException makeAppErr(
    AppException app, {
    String method = 'GET',
    Map<String, dynamic>? extra,
  }) {
    return DioException(
      requestOptions: RequestOptions(
        path: '/test',
        method: method,
        extra: extra ?? <String, dynamic>{},
      ),
      error: app,
    );
  }

  Future<DioException?> runError(DioException err) async {
    DioException? out;
    await interceptor.onError(err, _Handler(onNext: (e) => out = e));
    return out;
  }

  group('RetryInterceptor', () {
    test('passes through unrelated AppExceptions', () async {
      final out = await runError(
        makeAppErr(const AppException.invalidSignature()),
      );
      expect(out, isNotNull);
      expect(sleeps, isEmpty);
    });

    test('passes through Network(retriable: false)', () async {
      final out = await runError(makeAppErr(const AppException.network()));
      expect(out, isNotNull);
      expect(sleeps, isEmpty);
    });

    test('5xx GET schedules backoff up to maxNetworkRetries', () async {
      // First attempt: schedules a sleep, then real Dio fails (no server) →
      // returns the failing DioException. We can't intercept the inner
      // network call, so we instead check that the sleep happened with the
      // expected initial duration.
      await runError(makeAppErr(const AppException.network(retriable: true)));
      expect(sleeps, hasLength(1));
      expect(sleeps.first, const Duration(milliseconds: 500));
    });

    test('does not retry POST on 5xx', () async {
      await runError(
        makeAppErr(const AppException.network(retriable: true), method: 'POST'),
      );
      expect(sleeps, isEmpty);
    });

    test('does not retry DELETE on 5xx', () async {
      await runError(
        makeAppErr(
          const AppException.network(retriable: true),
          method: 'DELETE',
        ),
      );
      expect(sleeps, isEmpty);
    });

    test('IpBan never retries', () async {
      await runError(makeAppErr(const AppException.ipBan(message: 'banned')));
      expect(sleeps, isEmpty);
    });

    test('Auth never retries', () async {
      await runError(makeAppErr(const AppException.auth(message: 'no')));
      expect(sleeps, isEmpty);
    });

    test('RateLimit with Retry-After waits and retries once (GET)', () async {
      await runError(
        makeAppErr(
          const AppException.rateLimit(
            message: 'slow down',
            retryAfterSeconds: 3,
          ),
        ),
      );
      expect(sleeps, [const Duration(seconds: 3)]);
    });

    test('RateLimit on POST does not retry', () async {
      await runError(
        makeAppErr(
          const AppException.rateLimit(
            message: 'slow down',
            retryAfterSeconds: 3,
          ),
          method: 'POST',
        ),
      );
      expect(sleeps, isEmpty);
    });

    test('RateLimit without Retry-After does not retry', () async {
      await runError(makeAppErr(const AppException.rateLimit(message: 'slow')));
      expect(sleeps, isEmpty);
    });

    test('5xx stops retrying after maxNetworkRetries', () async {
      // Simulate having already used up the retry budget.
      await runError(
        makeAppErr(
          const AppException.network(retriable: true),
          extra: {'__binance_retry_attempts__': 2},
        ),
      );
      expect(sleeps, isEmpty);
    });
  });
}

class _Handler extends ErrorInterceptorHandler {
  _Handler({required this.onNext});
  final void Function(DioException) onNext;

  @override
  void next(DioException err) => onNext(err);

  @override
  void reject(
    DioException error, [
    bool callFollowingErrorInterceptor = false,
  ]) {}

  @override
  void resolve(Response<dynamic> response) {}
}
