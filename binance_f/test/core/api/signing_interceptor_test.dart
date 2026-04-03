import 'package:binance_f/core/api/signing_interceptor.dart';
import 'package:binance_f/core/security/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorageService {}

void main() {
  late MockSecureStorage mockStorage;
  late SigningInterceptor interceptor;

  setUp(() {
    mockStorage = MockSecureStorage();
    interceptor = SigningInterceptor(storage: mockStorage);
  });

  group('SigningInterceptor', () {
    test('adds signature and API key header when keys exist', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => 'test-api-key');
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => 'test-secret');

      final options = RequestOptions(
        path: '/api/v3/order',
        queryParameters: {'symbol': 'BTCUSDT'},
      );

      RequestOptions? result;
      interceptor.onRequest(
        options,
        _CapturingRequestHandler(onNext: (o) => result = o),
      );

      // Allow async to complete
      await Future<void>.delayed(Duration.zero);

      expect(result, isNotNull);
      expect(result!.headers['X-MBX-APIKEY'], 'test-api-key');
      expect(result!.queryParameters.containsKey('timestamp'), isTrue);
      expect(result!.queryParameters.containsKey('signature'), isTrue);
      expect((result!.queryParameters['signature'] as String).length, 64);
    });

    test('passes through unsigned when no keys', () async {
      when(
        () => mockStorage.read(key: 'binance_api_key'),
      ).thenAnswer((_) async => null);
      when(
        () => mockStorage.read(key: 'binance_api_secret'),
      ).thenAnswer((_) async => null);

      final options = RequestOptions(
        path: '/api/v3/ticker/price',
        queryParameters: {'symbol': 'BTCUSDT'},
      );

      RequestOptions? result;
      interceptor.onRequest(
        options,
        _CapturingRequestHandler(onNext: (o) => result = o),
      );

      await Future<void>.delayed(Duration.zero);

      expect(result, isNotNull);
      expect(result!.headers.containsKey('X-MBX-APIKEY'), isFalse);
      expect(result!.queryParameters.containsKey('signature'), isFalse);
    });
  });
}

class _CapturingRequestHandler extends RequestInterceptorHandler {
  _CapturingRequestHandler({this.onNext});

  final void Function(RequestOptions)? onNext;

  @override
  void next(RequestOptions options) => onNext?.call(options);
}
