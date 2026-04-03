import 'package:dio/dio.dart';

import '../models/api_error.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response == null) {
      handler.next(err);
      return;
    }

    final data = response.data;
    if (data is Map<String, dynamic> &&
        data.containsKey('code') &&
        data.containsKey('msg')) {
      final apiError = ApiError.fromJson(data);
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: response,
          error: ApiException(
            error: apiError,
            httpStatusCode: response.statusCode,
          ),
        ),
      );
      return;
    }

    handler.next(err);
  }
}
