import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Singleton row holding the last-known portfolio snapshot as JSON.
///
/// Phase 3 stores the entire [PortfolioSnapshot] JSON in a single row so
/// the offline read path can be a trivial `SELECT * FROM cached_portfolio
/// WHERE id=1`. Later phases (4, 8) will add proper tables for favorites,
/// cached orders, etc.
class CachedPortfolio extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();

  DateTimeColumn get fetchedAt => dateTime()();

  TextColumn get snapshotJson => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// The app's Drift database. Owned as a lazy singleton in get_it — see
/// `lib/core/di/service_locator.dart`.
///
/// The schema is intentionally minimal at Phase 3. Phases 4 / 8 / 9 / 11
/// will add favorites, cached orders, price alerts, and settings tables.
/// Migrations are versioned — never edit a past migration, always add a
/// new one.
@DriftDatabase(tables: [CachedPortfolio])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-only constructor that accepts a pre-built executor (e.g. an
  /// in-memory `NativeDatabase.memory()`).
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'binance_f');
}
