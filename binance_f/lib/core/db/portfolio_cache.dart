import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

import '../../features/portfolio/data/models/portfolio_snapshot.dart';
import '../models/app_exception.dart';
import 'app_database.dart';

/// Thin `TaskEither` wrapper around the `cached_portfolio` Drift table.
///
/// The provider layer talks to this rather than the raw database so the
/// fpdart convention (no throws) is preserved all the way down to the
/// storage boundary. Drift's own API throws; we wrap every call in
/// `TaskEither.tryCatch` and map any failure into `AppException.unknown`.
class PortfolioCache {
  PortfolioCache({required AppDatabase database}) : _db = database;

  final AppDatabase _db;

  /// Persist a snapshot. Uses `mode: InsertMode.insertOrReplace` so the
  /// single-row invariant (id=1) is maintained without a separate
  /// read-or-update branch.
  TaskEither<AppException, Unit> save(PortfolioSnapshot snapshot) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        // Clear the `stale` flag before persisting; offline reads set it
        // themselves on load.
        final clean = snapshot.copyWith(stale: false);
        final json = jsonEncode(clean.toJson());
        await _db
            .into(_db.cachedPortfolio)
            .insert(
              CachedPortfolioCompanion.insert(
                id: const Value(1),
                fetchedAt: clean.fetchedAt,
                snapshotJson: json,
              ),
              mode: InsertMode.insertOrReplace,
            );
        return unit;
      }, _toAppException);

  /// Load the most recent cached snapshot, if any.
  ///
  /// Returns `Right(null)` when the table is empty (first run, post
  /// logout) — the provider uses that to know there's no offline fallback
  /// and must escalate network failures to `AsyncError`.
  TaskEither<AppException, PortfolioSnapshot?> load() =>
      TaskEither<AppException, PortfolioSnapshot?>.tryCatch(() async {
        final row = await (_db.select(
          _db.cachedPortfolio,
        )..where((t) => t.id.equals(1))).getSingleOrNull();
        if (row == null) return null;
        final decoded = jsonDecode(row.snapshotJson) as Map<String, dynamic>;
        final snapshot = PortfolioSnapshot.fromJson(decoded);
        return snapshot.copyWith(stale: true, fetchedAt: row.fetchedAt);
      }, _toAppException);

  /// Wipe the cache. Called by `SessionManager.logout` during full wipe.
  TaskEither<AppException, Unit> clear() =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _db.delete(_db.cachedPortfolio).go();
        return unit;
      }, _toAppException);
}

AppException _toAppException(Object err, StackTrace _) {
  if (err is AppException) return err;
  return AppException.unknown(message: err.toString());
}
