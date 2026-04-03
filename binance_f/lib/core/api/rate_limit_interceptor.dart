import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

class RateLimitInterceptor extends Interceptor {
  RateLimitInterceptor({required Talker talker, this.maxRetries = 3})
    : _talker = talker;

  final Talker _talker;
  final int maxRetries;

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final weight = response.headers.value('X-MBX-USED-WEIGHT-1M');
    if (weight != null) {
      final used = int.tryParse(weight) ?? 0;
      if (used > 900) {
        _talker.warning('Binance rate limit weight at $used/1200');
      }
    }
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 418) {
      _talker.critical('IP banned by Binance (418)');
      handler.next(err);
      return;
    }

    if (statusCode == 429) {
      for (var attempt = 0; attempt < maxRetries; attempt++) {
        final delay = Duration(seconds: 1 << attempt);
        _talker.warning(
          'Rate limited (429). Retry ${attempt + 1}/$maxRetries '
          'after ${delay.inSeconds}s',
        );
        await Future<void>.delayed(delay);

        try {
          final response = await Dio().fetch<dynamic>(err.requestOptions);
          handler.resolve(response);
          return;
        } on DioException catch (retryErr) {
          if (retryErr.response?.statusCode != 429) {
            handler.next(retryErr);
            return;
          }
        }
      }
    }

    handler.next(err);
  }
}
