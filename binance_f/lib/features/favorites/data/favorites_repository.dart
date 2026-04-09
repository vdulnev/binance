import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/db/app_database.dart';
import '../../../core/models/app_exception.dart';
import 'models/favorite_symbol.dart';

/// Data access for the user-editable favorites list, backed by the
/// Drift `favorites` table.
///
/// All methods return `TaskEither<AppException, T>` — failures are
/// values, not thrown exceptions.
abstract class FavoritesRepository {
  TaskEither<AppException, List<FavoriteSymbol>> getAll();
  TaskEither<AppException, Unit> add(String symbol, String market);
  TaskEither<AppException, Unit> remove(String symbol, String market);
  TaskEither<AppException, Unit> reorder(List<FavoriteSymbol> ordered);
  TaskEither<AppException, bool> isFavorite(String symbol, String market);
}

class DriftFavoritesRepository implements FavoritesRepository {
  DriftFavoritesRepository({required AppDatabase database}) : _db = database;

  final AppDatabase _db;

  @override
  TaskEither<AppException, List<FavoriteSymbol>> getAll() =>
      TaskEither<AppException, List<FavoriteSymbol>>.tryCatch(() async {
        final rows = await (_db.select(
          _db.favorites,
        )..orderBy([(t) => OrderingTerm.asc(t.position)])).get();
        return rows
            .map(
              (r) => FavoriteSymbol(
                symbol: r.symbol,
                market: r.market,
                position: r.position,
              ),
            )
            .toList(growable: false);
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> add(String symbol, String market) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        // Assign position as max(position)+1 so the new item appears
        // at the end of the list.
        final maxPos = await _maxPosition();
        await _db
            .into(_db.favorites)
            .insert(
              FavoritesCompanion.insert(
                symbol: symbol,
                market: market,
                position: maxPos + 1,
              ),
              mode: InsertMode.insertOrReplace,
            );
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> remove(String symbol, String market) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await (_db.delete(_db.favorites)
              ..where((t) => t.symbol.equals(symbol) & t.market.equals(market)))
            .go();
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, Unit> reorder(List<FavoriteSymbol> ordered) =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _db.batch((batch) {
          for (var i = 0; i < ordered.length; i++) {
            final fav = ordered[i];
            batch.insert(
              _db.favorites,
              FavoritesCompanion.insert(
                symbol: fav.symbol,
                market: fav.market,
                position: i,
              ),
              mode: InsertMode.insertOrReplace,
            );
          }
        });
        return unit;
      }, _toAppException);

  @override
  TaskEither<AppException, bool> isFavorite(String symbol, String market) =>
      TaskEither<AppException, bool>.tryCatch(() async {
        final row =
            await (_db.select(_db.favorites)..where(
                  (t) => t.symbol.equals(symbol) & t.market.equals(market),
                ))
                .getSingleOrNull();
        return row != null;
      }, _toAppException);

  /// Wipe the entire favorites table. Called by `SessionManager.logout`.
  TaskEither<AppException, Unit> clearAll() =>
      TaskEither<AppException, Unit>.tryCatch(() async {
        await _db.delete(_db.favorites).go();
        return unit;
      }, _toAppException);

  Future<int> _maxPosition() async {
    final rows =
        await (_db.select(_db.favorites)
              ..orderBy([(t) => OrderingTerm.desc(t.position)])
              ..limit(1))
            .get();
    if (rows.isEmpty) return -1;
    return rows.first.position;
  }
}

AppException _toAppException(Object err, StackTrace _) {
  if (err is AppException) return err;
  return AppException.unknown(message: err.toString());
}
