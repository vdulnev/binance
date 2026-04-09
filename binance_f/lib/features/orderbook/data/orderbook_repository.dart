import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/models/app_exception.dart';
import '../../auth/data/auth_repository.dart' show DioProvider;
import 'models/order_book.dart';
import 'models/order_book_entry.dart';
import 'models/recent_trade.dart';

/// Data access for per-symbol order book depth and recent trades.
///
/// Uses `GET /api/v3/depth` and `GET /api/v3/trades` — both NONE security,
/// no signing required.
abstract class OrderBookRepository {
  TaskEither<AppException, OrderBook> getSnapshot(
    String symbol, {
    int limit = 20,
  });

  TaskEither<AppException, List<RecentTrade>> getRecentTrades(
    String symbol, {
    int limit = 50,
  });
}

class BinanceOrderBookRepository implements OrderBookRepository {
  BinanceOrderBookRepository({required DioProvider spotDio}) : _spot = spotDio;

  final DioProvider _spot;

  @override
  TaskEither<AppException, OrderBook> getSnapshot(
    String symbol, {
    int limit = 20,
  }) {
    return TaskEither<AppException, OrderBook>.tryCatch(() async {
      final response = await _spot().get<Map<String, dynamic>>(
        '/api/v3/depth',
        queryParameters: <String, dynamic>{'symbol': symbol, 'limit': limit},
      );

      final data = response.data ?? const <String, dynamic>{};
      final lastUpdateId = data['lastUpdateId'] as int? ?? 0;

      final rawBids = (data['bids'] as List?) ?? const [];
      final bids = rawBids
          .whereType<List<dynamic>>()
          .map(OrderBookEntry.fromBinanceList)
          .toList(growable: false);

      final rawAsks = (data['asks'] as List?) ?? const [];
      final asks = rawAsks
          .whereType<List<dynamic>>()
          .map(OrderBookEntry.fromBinanceList)
          .toList(growable: false);

      return OrderBook(
        symbol: symbol,
        lastUpdateId: lastUpdateId,
        bids: bids,
        asks: asks,
      );
    }, _toAppException);
  }

  @override
  TaskEither<AppException, List<RecentTrade>> getRecentTrades(
    String symbol, {
    int limit = 50,
  }) {
    return TaskEither<AppException, List<RecentTrade>>.tryCatch(() async {
      final response = await _spot().get<List<dynamic>>(
        '/api/v3/trades',
        queryParameters: <String, dynamic>{'symbol': symbol, 'limit': limit},
      );

      final list = response.data ?? const [];
      return list
          .whereType<Map<String, dynamic>>()
          .map(RecentTrade.fromJson)
          .toList(growable: false);
    }, _toAppException);
  }
}

AppException _toAppException(Object err, StackTrace _) {
  if (err is AppException) return err;
  if (err is DioException && err.error is AppException) {
    return err.error! as AppException;
  }
  return AppException.unknown(message: err.toString());
}
