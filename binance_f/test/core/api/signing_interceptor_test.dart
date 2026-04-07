import 'dart:async';

import 'package:binance_f/core/api/signing_interceptor.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/core/security/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorageService {}

class _FakeTimeSyncDio extends Fake implements Dio {
  _FakeTimeSyncDio();

  final int serverTime = 1700000000000;
  int callCount = 0;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    callCount++;
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      data: <String, dynamic>{'serverTime': serverTime} as T,
      statusCode: 200,
    );
  }
}

void main() {
  late MockSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockSecureStorage();
  });

  group('SigningInterceptor.onRequest', () {
    test('adds signature, header, and timestamp when keys exist', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'test-api-key');
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => 'test-secret');

      final fakeTime = _FakeTimeSyncDio();
      final interceptor = SigningInterceptor(
        storage: mockStorage,
        timeSyncClient: fakeTime,
      );

      final options = RequestOptions(
        path: '/api/v3/order',
        queryParameters: {'symbol': 'BTCUSDT'},
      );

      final completer = Completer<RequestOptions>();
      await interceptor.onRequest(
        options,
        _CapturingReqHandler(onNext: completer.complete),
      );

      final result = await completer.future;
      expect(result.headers['X-MBX-APIKEY'], 'test-api-key');
      expect(result.queryParameters.containsKey('timestamp'), isTrue);
      expect(result.queryParameters.containsKey('signature'), isTrue);
      expect((result.queryParameters['signature']! as String).length, 64);
      expect(fakeTime.callCount, 1, reason: 'first request triggers sync');
    });

    test('passes through unsigned when no keys', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => null);
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => null);

      final interceptor = SigningInterceptor(storage: mockStorage);

      final options = RequestOptions(
        path: '/api/v3/ticker/price',
        queryParameters: {'symbol': 'BTCUSDT'},
      );
      final completer = Completer<RequestOptions>();
      await interceptor.onRequest(
        options,
        _CapturingReqHandler(onNext: completer.complete),
      );

      final result = await completer.future;
      expect(result.headers.containsKey('X-MBX-APIKEY'), isFalse);
      expect(result.queryParameters.containsKey('signature'), isFalse);
    });

    test('time sync only happens once across multiple requests', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'k');
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => 's');

      final fakeTime = _FakeTimeSyncDio();
      final interceptor = SigningInterceptor(
        storage: mockStorage,
        timeSyncClient: fakeTime,
      );

      for (var i = 0; i < 3; i++) {
        final c = Completer<RequestOptions>();
        await interceptor.onRequest(
          RequestOptions(path: '/api/v3/account'),
          _CapturingReqHandler(onNext: c.complete),
        );
        await c.future;
      }
      expect(fakeTime.callCount, 1);
    });
  });

  group('SigningInterceptor.onError', () {
    test('non-clock-skew errors pass through unchanged', () async {
      final interceptor = SigningInterceptor(storage: mockStorage);
      final err = DioException(
        requestOptions: RequestOptions(path: '/x'),
        error: const AppException.invalidSignature(),
      );

      DioException? out;
      await interceptor.onError(
        err,
        _CapturingErrHandler(onNext: (e) => out = e),
      );
      expect(out, same(err));
    });

    test('clock-skew with retry flag already set passes through', () async {
      final interceptor = SigningInterceptor(storage: mockStorage);
      final ro = RequestOptions(
        path: '/x',
        extra: {'__binance_signing_retried__': true},
      );
      final err = DioException(
        requestOptions: ro,
        error: const AppException.clockSkew(),
      );

      DioException? out;
      await interceptor.onError(
        err,
        _CapturingErrHandler(onNext: (e) => out = e),
      );
      expect(out, same(err));
    });
  });
}

class _CapturingReqHandler extends RequestInterceptorHandler {
  _CapturingReqHandler({required this.onNext});
  final void Function(RequestOptions) onNext;

  @override
  void next(RequestOptions options) => onNext(options);
}

class _CapturingErrHandler extends ErrorInterceptorHandler {
  _CapturingErrHandler({this.onNext});
  final void Function(DioException)? onNext;

  @override
  void next(DioException err) => onNext?.call(err);
}
