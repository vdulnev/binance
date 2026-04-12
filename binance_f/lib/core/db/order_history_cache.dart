import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

import '../../features/trade/data/models/futures_order.dart';
import '../../features/trade/data/models/spot_order.dart';
import '../models/app_exception.dart';
import 'app_database.dart';

/// Thin `TaskEither` wrapper around the `cached_orders` Drift table.
///
/// Stores order history for offline viewing (FR-6.2, FR-9.1). The provider
/// layer writes fresh API results here and reads cached data when offline.
class OrderHistoryCache {
  OrderHistoryCache({required AppDatabase database}) : _db = database;

  final AppDatabase _db;

  // -------------------------------------------------------------------
  // Write
  // -------------------------------------------------------------------

  /// Persist a batch of spot orders. Uses insertOrReplace so re-fetching
  /// the same orders updates their cached state.
  TaskEither<AppException, Unit> saveSpotOrders(List<SpotOrder> orders) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _db.batch((batch) {
          batch.insertAllOnConflictUpdate(
            _db.cachedOrders,
            orders.map(
              (o) => CachedOrdersCompanion.insert(
                orderId: o.orderId,
                symbol: o.symbol,
                market: 'spot',
                orderJson: jsonEncode(o.toJson()),
                orderTime: o.time,
                fetchedAt: DateTime.now().toUtc(),
              ),
            ),
          );
        });
        return unit;
      }, _toAppException);

  /// Persist a batch of futures orders.
  TaskEither<AppException, Unit> saveFuturesOrders(List<FuturesOrder> orders) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _db.batch((batch) {
          batch.insertAllOnConflictUpdate(
            _db.cachedOrders,
            orders.map(
              (o) => CachedOrdersCompanion.insert(
                orderId: o.orderId,
                symbol: o.symbol,
                market: 'futures',
                orderJson: jsonEncode(o.toJson()),
                orderTime: o.time,
                fetchedAt: DateTime.now().toUtc(),
              ),
            ),
          );
        });
        return unit;
      }, _toAppException);

  // -------------------------------------------------------------------
  // Read
  // -------------------------------------------------------------------

  /// Load cached spot orders, optionally filtered by symbol and/or date.
  TaskEither<AppException, List<SpotOrder>> loadSpotOrders({
    String? symbol,
    DateTime? startTime,
    DateTime? endTime,
  }) => TaskEither<AppException, List<SpotOrder>>.tryCatch(() async {
    final query = _db.select(_db.cachedOrders)
      ..where((t) => t.market.equals('spot'));
    if (symbol != null) {
      query.where((t) => t.symbol.equals(symbol));
    }
    if (startTime != null) {
      query.where(
        (t) =>
            t.orderTime.isBiggerOrEqualValue(startTime.millisecondsSinceEpoch),
      );
    }
    if (endTime != null) {
      query.where(
        (t) =>
            t.orderTime.isSmallerOrEqualValue(endTime.millisecondsSinceEpoch),
      );
    }
    query.orderBy([(t) => OrderingTerm.desc(t.orderTime)]);
    final rows = await query.get();
    return rows.map((row) {
      final json = jsonDecode(row.orderJson) as Map<String, dynamic>;
      return SpotOrder.fromJson(json);
    }).toList();
  }, _toAppException);

  /// Load cached futures orders, optionally filtered by symbol and/or date.
  TaskEither<AppException, List<FuturesOrder>> loadFuturesOrders({
    String? symbol,
    DateTime? startTime,
    DateTime? endTime,
  }) => TaskEither<AppException, List<FuturesOrder>>.tryCatch(() async {
    final query = _db.select(_db.cachedOrders)
      ..where((t) => t.market.equals('futures'));
    if (symbol != null) {
      query.where((t) => t.symbol.equals(symbol));
    }
    if (startTime != null) {
      query.where(
        (t) =>
            t.orderTime.isBiggerOrEqualValue(startTime.millisecondsSinceEpoch),
      );
    }
    if (endTime != null) {
      query.where(
        (t) =>
            t.orderTime.isSmallerOrEqualValue(endTime.millisecondsSinceEpoch),
      );
    }
    query.orderBy([(t) => OrderingTerm.desc(t.orderTime)]);
    final rows = await query.get();
    return rows.map((row) {
      final json = jsonDecode(row.orderJson) as Map<String, dynamic>;
      return FuturesOrder.fromJson(json);
    }).toList();
  }, _toAppException);

  /// All distinct symbols that have cached orders for a given market.
  TaskEither<AppException, List<String>> cachedSymbols(String market) =>
      TaskEither<AppException, List<String>>.tryCatch(() async {
        final query = _db.selectOnly(_db.cachedOrders, distinct: true)
          ..addColumns([_db.cachedOrders.symbol])
          ..where(_db.cachedOrders.market.equals(market));
        final rows = await query.get();
        return rows.map((row) => row.read(_db.cachedOrders.symbol)!).toList();
      }, _toAppException);

  // -------------------------------------------------------------------
  // Delete
  // -------------------------------------------------------------------

  /// Wipe all cached orders. Called by `SessionManager.logout`.
  TaskEither<AppException, Unit> clear() =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _db.delete(_db.cachedOrders).go();
        return unit;
      }, _toAppException);
}

AppException _toAppException(Object err, StackTrace _) {
  if (err is AppException) return err;
  return AppException.unknown(message: err.toString());
}
