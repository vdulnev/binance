import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/auth/session_manager.dart';
import '../../../core/models/app_exception.dart';
import '../../auth/data/auth_repository.dart' show DioProvider;
import '../../trade/data/models/futures_order.dart';
import '../../trade/data/models/spot_order.dart';

/// Data access for historical orders: `GET /api/v3/allOrders` (spot) and
/// `GET /fapi/v1/allOrders` (futures).
///
/// Both Binance endpoints require a `symbol` parameter.
abstract class OrderHistoryRepository {
  /// Fetch all spot orders for [symbol], optionally filtered by date.
  /// Results are sorted newest-first.
  TaskEither<AppException, List<SpotOrder>> getSpotOrders({
    required String symbol,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 500,
  });

  /// Fetch all futures orders for [symbol], optionally filtered by date.
  TaskEither<AppException, List<FuturesOrder>> getFuturesOrders({
    required String symbol,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 500,
  });
}

class BinanceOrderHistoryRepository implements OrderHistoryRepository {
  BinanceOrderHistoryRepository({
    required DioProvider spotDio,
    required DioProvider futuresDio,
    SessionManager? sessionManager,
  }) : _spot = spotDio,
       _futures = futuresDio,
       _sessionManager = sessionManager;

  final DioProvider _spot;
  final DioProvider _futures;
  final SessionManager? _sessionManager;

  @override
  TaskEither<AppException, List<SpotOrder>> getSpotOrders({
    required String symbol,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 500,
  }) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, List<SpotOrder>>.tryCatch(() async {
      final params = <String, dynamic>{'symbol': symbol, 'limit': limit};
      if (startTime != null) {
        params['startTime'] = startTime.millisecondsSinceEpoch;
      }
      if (endTime != null) {
        params['endTime'] = endTime.millisecondsSinceEpoch;
      }

      final response = await _spot().get<List<dynamic>>(
        '/api/v3/allOrders',
        queryParameters: params,
        cancelToken: cancelToken,
      );
      final orders =
          (response.data ?? const [])
              .whereType<Map<String, dynamic>>()
              .map(SpotOrder.fromJson)
              .toList(growable: false)
            ..sort((a, b) => b.time.compareTo(a.time));
      return orders;
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  @override
  TaskEither<AppException, List<FuturesOrder>> getFuturesOrders({
    required String symbol,
    DateTime? startTime,
    DateTime? endTime,
    int limit = 500,
  }) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, List<FuturesOrder>>.tryCatch(() async {
      final params = <String, dynamic>{'symbol': symbol, 'limit': limit};
      if (startTime != null) {
        params['startTime'] = startTime.millisecondsSinceEpoch;
      }
      if (endTime != null) {
        params['endTime'] = endTime.millisecondsSinceEpoch;
      }

      final response = await _futures().get<List<dynamic>>(
        '/fapi/v1/allOrders',
        queryParameters: params,
        cancelToken: cancelToken,
      );
      final orders =
          (response.data ?? const [])
              .whereType<Map<String, dynamic>>()
              .map(FuturesOrder.fromJson)
              .toList(growable: false)
            ..sort((a, b) => b.time.compareTo(a.time));
      return orders;
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  T Function(T) _cleanup<T>(CancelToken token) {
    return (value) {
      _sessionManager?.unregisterCancelToken(token);
      return value;
    };
  }

  AppException _toAppException(Object err, StackTrace _) {
    if (err is AppException) return err;
    if (err is DioException && err.error is AppException) {
      return err.error! as AppException;
    }
    return AppException.unknown(message: err.toString());
  }
}
