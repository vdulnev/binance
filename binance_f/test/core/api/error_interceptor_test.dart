import 'package:binance_f/core/api/error_interceptor.dart';
import 'package:binance_f/core/models/api_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ErrorInterceptor interceptor;

  setUp(() {
    interceptor = ErrorInterceptor();
  });

  group('ErrorInterceptor', () {
    test('parses Binance error response into ApiException', () {
      final requestOptions = RequestOptions(path: '/test');
      final response = Response<dynamic>(
        requestOptions: requestOptions,
        statusCode: 400,
        data: <String, dynamic>{'code': -1022, 'msg': 'Invalid signature.'},
      );
      final err = DioException(
        requestOptions: requestOptions,
        response: response,
      );

      DioException? rejected;

      interceptor.onError(
        err,
        _CapturingHandler(onReject: (e) => rejected = e),
      );

      expect(rejected, isNotNull);
      expect(rejected!.error, isA<ApiException>());
      final apiException = rejected!.error as ApiException;
      expect(apiException.error.code, -1022);
      expect(apiException.error.msg, 'Invalid signature.');
      expect(apiException.httpStatusCode, 400);
      expect(apiException.isInvalidSignature, isTrue);
    });

    test('passes through non-Binance errors', () {
      final requestOptions = RequestOptions(path: '/test');
      final err = DioException(
        requestOptions: requestOptions,
        response: Response<dynamic>(
          requestOptions: requestOptions,
          statusCode: 500,
          data: 'Internal Server Error',
        ),
      );

      DioException? passed;
      interceptor.onError(err, _CapturingHandler(onNext: (e) => passed = e));

      expect(passed, isNotNull);
      expect(passed!.error, isNot(isA<ApiException>()));
    });

    test('passes through when no response', () {
      final requestOptions = RequestOptions(path: '/test');
      final err = DioException(requestOptions: requestOptions);

      DioException? passed;
      interceptor.onError(err, _CapturingHandler(onNext: (e) => passed = e));

      expect(passed, isNotNull);
    });
  });
}

class _CapturingHandler extends ErrorInterceptorHandler {
  _CapturingHandler({this.onReject, this.onNext});

  final void Function(DioException)? onReject;
  final void Function(DioException)? onNext;

  @override
  void reject(DioException err) => onReject?.call(err);

  @override
  void next(DioException err) => onNext?.call(err);
}
