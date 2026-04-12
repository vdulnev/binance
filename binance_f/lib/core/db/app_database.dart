import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Singleton row holding the last-known portfolio snapshot as JSON.
///
/// Phase 3 stores the entire [PortfolioSnapshot] JSON in a single row so
/// the offline read path can be a trivial `SELECT * FROM cached_portfolio
/// WHERE id=1`. Later phases (8) will add proper tables for cached orders.
class CachedPortfolio extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();

  DateTimeColumn get fetchedAt => dateTime()();

  TextColumn get snapshotJson => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// User-editable favorites list. Each row is a `(symbol, market)` pair
/// with a `position` column controlling sort order. Phase 4.
class Favorites extends Table {
  TextColumn get symbol => text()();
  TextColumn get market => text()();
  IntColumn get position => integer()();

  @override
  Set<Column<Object>> get primaryKey => {symbol, market};
}

/// Cached exchange info symbols. Phase 4 stores each symbol from the
/// `GET /api/v3/exchangeInfo` and `GET /fapi/v1/exchangeInfo` responses
/// so client-side filter validation works offline (Phase 5/6).
class CachedSymbols extends Table {
  TextColumn get symbol => text()();
  TextColumn get market => text()();
  TextColumn get baseAsset => text()();
  TextColumn get quoteAsset => text()();
  TextColumn get status => text()();
  TextColumn get filtersJson => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {symbol, market};
}

/// Cached order history for offline viewing (Phase 8 — FR-6.2, FR-9.1).
///
/// Each row stores one historical order (spot or futures) as JSON plus
/// indexed fields for efficient querying by symbol, market, and date.
class CachedOrders extends Table {
  IntColumn get orderId => integer()();
  TextColumn get symbol => text()();
  TextColumn get market => text()(); // 'spot' or 'futures'
  TextColumn get orderJson => text()();

  /// Order creation time in ms since epoch — used for date filtering.
  IntColumn get orderTime => integer()();

  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {orderId, market};
}

/// The app's Drift database. Owned as a lazy singleton in get_it — see
/// `lib/core/di/service_locator.dart`.
///
/// Migrations are versioned — never edit a past migration, always add a
/// new one.
@DriftDatabase(
  tables: [CachedPortfolio, Favorites, CachedSymbols, CachedOrders],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-only constructor that accepts a pre-built executor (e.g. an
  /// in-memory `NativeDatabase.memory()`).
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(favorites);
        await m.createTable(cachedSymbols);
      }
      if (from < 3) {
        await m.createTable(cachedOrders);
      }
    },
  );
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'binance_f');
}
