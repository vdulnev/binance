import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

/// Observes Binance rate-limit response headers and warns when usage is
/// approaching the cap. Retries on 429 are handled by [RetryInterceptor]
/// after the error has been mapped to a typed [AppException].
class RateLimitInterceptor extends Interceptor {
  RateLimitInterceptor({required Talker talker}) : _talker = talker;

  final Talker _talker;

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
}
