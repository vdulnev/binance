import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/db/app_database.dart';
import '../../../core/models/app_exception.dart';
import 'models/price_alert.dart';

/// Data access for local price alerts, backed by the Drift
/// `price_alerts` table (Phase 9 — FR-7.1).
///
/// All mutation methods return `TaskEither<AppException, T>`. The
/// [watchEnabled] stream is raw (not TaskEither) because Drift watch
/// queries are long-lived and errors are handled via stream error
/// callbacks in the consumer.
abstract class AlertsRepository {
  TaskEither<AppException, List<PriceAlert>> getAll();
  TaskEither<AppException, List<PriceAlert>> getEnabled();
  TaskEither<AppException, PriceAlert> create({
    required String symbol,
    required String market,
    required AlertDirection direction,
    required Decimal targetPrice,
  });
  TaskEither<AppException, Unit> delete(int id);
  TaskEither<AppException, Unit> setEnabled(int id, {required bool enabled});
  TaskEither<AppException, Unit> markTriggered(int id, DateTime triggeredAt);
  TaskEither<AppException, Unit> clearAll();

  /// Reactive stream of enabled, untriggered alerts for the evaluator.
  Stream<List<PriceAlert>> watchEnabled();
}

class DriftAlertsRepository implements AlertsRepository {
  DriftAlertsRepository({required AppDatabase database}) : _db = database;

  final AppDatabase _db;

  @override
  TaskEither<AppException, List<PriceAlert>> getAll() =>
      TaskEither<AppException, List<PriceAlert>>.tryCatch(() async {
        final rows = await (_db.select(
          _db.priceAlerts,
        )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
        return rows.map(_fromRow).toList(growable: false);
      }, _toAppException);

  @override
  TaskEither<AppException, List<PriceAlert>> getEnabled() =>
      TaskEither<AppException, List<PriceAlert>>.tryCatch(() async {
        final rows =
            await (_db.select(_db.priceAlerts)
                  ..where(
                    (t) => t.enabled.equals(true) & t.triggeredAt.isNull(),
                  )
                  ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
                .get();
        return rows.map(_fromRow).toList(growable: false);
      }, _toAppException);

  @override
  TaskEither<AppException, PriceAlert> create({
    required String symbol,
    required String market,
    required AlertDirection direction,
    required Decimal targetPrice,
  }) => TaskEither<AppException, PriceAlert>.tryCatch(() async {
    final id = await _db
        .into(_db.priceAlerts)
        .insert(
          PriceAlertsCompanion.insert(
            symbol: symbol,
            market: market,
            direction: direction.name,
            targetPrice: targetPrice.toString(),
          ),
        );
    final row = await (_db.select(
      _db.priceAlerts,
    )..where((t) => t.id.equals(id))).getSingle();
    return _fromRow(row);
  }, _toAppException);

  @override
  TaskEither<AppException, Unit> delete(int id) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await (_db.delete(_db.priceAlerts)..where((t) => t.id.equals(id))).go();
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> setEnabled(int id, {required bool enabled}) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await (_db.update(_db.priceAlerts)..where((t) => t.id.equals(id)))
            .write(PriceAlertsCompanion(enabled: Value(enabled)));
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> markTriggered(int id, DateTime triggeredAt) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await (_db.update(
          _db.priceAlerts,
        )..where((t) => t.id.equals(id))).write(
          PriceAlertsCompanion(
            triggeredAt: Value(triggeredAt),
            enabled: const Value(false),
          ),
        );
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> clearAll() =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _db.delete(_db.priceAlerts).go();
        return unit;
      }, _toAppException);

  @override
  Stream<List<PriceAlert>> watchEnabled() =>
      (_db.select(_db.priceAlerts)
            ..where((t) => t.enabled.equals(true) & t.triggeredAt.isNull())
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch()
          .map((rows) => rows.map(_fromRow).toList(growable: false));

  PriceAlert _fromRow(PriceAlertRow row) => PriceAlert(
    id: row.id,
    symbol: row.symbol,
    market: row.market,
    direction: AlertDirection.fromString(row.direction),
    targetPrice: Decimal.parse(row.targetPrice),
    enabled: row.enabled,
    createdAt: row.createdAt,
    triggeredAt: row.triggeredAt,
  );
}

AppException _toAppException(Object err, StackTrace _) {
  if (err is AppException) return err;
  return AppException.unknown(message: err.toString());
}
