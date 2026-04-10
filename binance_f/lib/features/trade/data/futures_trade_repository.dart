import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/auth/session_manager.dart';
import '../../../core/models/app_exception.dart';
import '../../auth/data/auth_repository.dart' show DioProvider;
import 'models/futures_order.dart';
import 'models/order_enums.dart';

/// Data access for USDⓈ-M futures trading: place, cancel, query orders.
///
/// Every method returns `TaskEither<AppException, T>`.
abstract class FuturesTradeRepository {
  /// `POST /fapi/v1/order` — place a futures order.
  TaskEither<AppException, FuturesOrder> placeOrder({
    required String symbol,
    required OrderSide side,
    required OrderType type,
    required Decimal quantity,
    required String clientOrderId,
    Decimal? price,
    Decimal? stopPrice,
    Decimal? callbackRate,
    TimeInForce? timeInForce,
    bool reduceOnly = false,
    bool postOnly = false,
  });

  /// `DELETE /fapi/v1/order` — cancel a single order.
  TaskEither<AppException, FuturesOrder> cancelOrder({
    required String symbol,
    required int orderId,
  });

  /// `DELETE /fapi/v1/allOpenOrders` — cancel all open orders for a symbol.
  TaskEither<AppException, Unit> cancelAllOrders({required String symbol});

  /// `GET /fapi/v1/openOrders` — all open futures orders.
  TaskEither<AppException, List<FuturesOrder>> getOpenOrders({String? symbol});

  /// `GET /fapi/v1/order` — query a single order (EC-9 reconciliation).
  TaskEither<AppException, FuturesOrder> queryOrder({
    required String symbol,
    String? clientOrderId,
    int? orderId,
  });
}

class BinanceFuturesTradeRepository implements FuturesTradeRepository {
  BinanceFuturesTradeRepository({
    required DioProvider futuresDio,
    SessionManager? sessionManager,
  }) : _futures = futuresDio,
       _sessionManager = sessionManager;

  final DioProvider _futures;
  final SessionManager? _sessionManager;

  @override
  TaskEither<AppException, FuturesOrder> placeOrder({
    required String symbol,
    required OrderSide side,
    required OrderType type,
    required Decimal quantity,
    required String clientOrderId,
    Decimal? price,
    Decimal? stopPrice,
    Decimal? callbackRate,
    TimeInForce? timeInForce,
    bool reduceOnly = false,
    bool postOnly = false,
  }) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, FuturesOrder>.tryCatch(() async {
      final params = <String, dynamic>{
        'symbol': symbol,
        'side': side.name,
        'type': type.name,
        'quantity': quantity.toString(),
        'newClientOrderId': clientOrderId,
        'newOrderRespType': 'RESULT',
      };
      if (price != null) params['price'] = price.toString();
      if (stopPrice != null) params['stopPrice'] = stopPrice.toString();
      if (callbackRate != null) {
        params['callbackRate'] = callbackRate.toString();
      }
      if (timeInForce != null) params['timeInForce'] = timeInForce.name;
      if (reduceOnly) params['reduceOnly'] = 'true';
      // Post-only is expressed as timeInForce=GTX in Binance futures.
      if (postOnly && timeInForce == null) {
        params['timeInForce'] = TimeInForce.GTX.name;
      }

      final response = await _futures().post<Map<String, dynamic>>(
        '/fapi/v1/order',
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return FuturesOrder.fromJson(response.data!);
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  @override
  TaskEither<AppException, FuturesOrder> cancelOrder({
    required String symbol,
    required int orderId,
  }) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, FuturesOrder>.tryCatch(() async {
      final response = await _futures().delete<Map<String, dynamic>>(
        '/fapi/v1/order',
        queryParameters: <String, dynamic>{
          'symbol': symbol,
          'orderId': orderId,
        },
        cancelToken: cancelToken,
      );
      return FuturesOrder.fromJson(response.data!);
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  @override
  TaskEither<AppException, Unit> cancelAllOrders({required String symbol}) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, Unit>.tryCatch(() async {
      await _futures().delete<Map<String, dynamic>>(
        '/fapi/v1/allOpenOrders',
        queryParameters: <String, dynamic>{'symbol': symbol},
        cancelToken: cancelToken,
      );
      return unit;
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  @override
  TaskEither<AppException, List<FuturesOrder>> getOpenOrders({String? symbol}) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, List<FuturesOrder>>.tryCatch(() async {
      final params = <String, dynamic>{};
      if (symbol != null) params['symbol'] = symbol;

      final response = await _futures().get<List<dynamic>>(
        '/fapi/v1/openOrders',
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return (response.data ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(FuturesOrder.fromJson)
          .toList(growable: false);
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  @override
  TaskEither<AppException, FuturesOrder> queryOrder({
    required String symbol,
    String? clientOrderId,
    int? orderId,
  }) {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, FuturesOrder>.tryCatch(() async {
      final params = <String, dynamic>{'symbol': symbol};
      if (orderId != null) params['orderId'] = orderId;
      if (clientOrderId != null) {
        params['origClientOrderId'] = clientOrderId;
      }

      final response = await _futures().get<Map<String, dynamic>>(
        '/fapi/v1/order',
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return FuturesOrder.fromJson(response.data!);
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  // -------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------

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
