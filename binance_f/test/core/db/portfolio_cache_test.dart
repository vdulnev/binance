import 'package:binance_f/core/db/app_database.dart';
import 'package:binance_f/core/db/portfolio_cache.dart';
import 'package:binance_f/features/portfolio/data/models/futures_account_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/portfolio_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/spot_account_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/spot_balance.dart';
import 'package:decimal/decimal.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

PortfolioSnapshot sampleSnapshot(DateTime at) {
  return PortfolioSnapshot(
    spot: SpotAccountSnapshot(
      fetchedAt: at,
      balances: [
        SpotBalance(
          asset: 'BTC',
          free: Decimal.parse('1.5'),
          locked: Decimal.zero,
        ),
      ],
    ),
    futures: FuturesAccountSnapshot(
      fetchedAt: at,
      assets: const [],
      positions: const [],
      totalWalletBalance: Decimal.parse('1000'),
      totalUnrealizedProfit: Decimal.zero,
      totalMarginBalance: Decimal.parse('1000'),
    ),
    totalValueInQuote: Decimal.parse('46000'),
    quoteAsset: 'USDT',
    fetchedAt: at,
  );
}

void main() {
  late AppDatabase db;
  late PortfolioCache cache;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    cache = PortfolioCache(database: db);
  });

  tearDown(() async {
    await db.close();
  });

  test('load returns Right(null) when the table is empty', () async {
    final r = await cache.load().run();
    expect(r.isRight(), isTrue);
    expect(r.getOrElse((_) => sampleSnapshot(DateTime.now())), isNull);
  });

  test('save then load round-trips the snapshot', () async {
    final at = DateTime.utc(2026, 4, 8, 12);
    final snap = sampleSnapshot(at);

    final saveR = await cache.save(snap).run();
    expect(saveR.isRight(), isTrue);

    final loadR = await cache.load().run();
    expect(loadR.isRight(), isTrue);
    final loaded = loadR.getOrElse((_) => null);
    expect(loaded, isNotNull);
    expect(loaded!.totalValueInQuote, snap.totalValueInQuote);
    expect(loaded.spot.balances, hasLength(1));
    expect(loaded.spot.balances.first.asset, 'BTC');

    // Loaded snapshots are always marked stale (the provider clears the
    // flag on the next live fetch).
    expect(loaded.stale, isTrue);
  });

  test('save replaces the singleton row (id=1) instead of appending', () async {
    final first = sampleSnapshot(DateTime.utc(2026, 4, 8, 10));
    final second = sampleSnapshot(DateTime.utc(2026, 4, 8, 11))
        .copyWith(totalValueInQuote: Decimal.parse('99999'));

    await cache.save(first).run();
    await cache.save(second).run();

    final loaded = (await cache.load().run()).getOrElse((_) => null);
    expect(loaded?.totalValueInQuote, Decimal.parse('99999'));

    // Only one row in the table.
    final rows = await db.select(db.cachedPortfolio).get();
    expect(rows, hasLength(1));
  });

  test('clear wipes the cache and a subsequent load returns null', () async {
    await cache.save(sampleSnapshot(DateTime.now())).run();

    final clearR = await cache.clear().run();
    expect(clearR.isRight(), isTrue);

    final loadR = await cache.load().run();
    expect(loadR.getOrElse((_) => sampleSnapshot(DateTime.now())), isNull);
  });
}
