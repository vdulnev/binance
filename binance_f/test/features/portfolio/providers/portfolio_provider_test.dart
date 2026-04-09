import 'dart:async';

import 'package:binance_f/core/db/portfolio_cache.dart';
import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/core/ws/user_data_event.dart';
import 'package:binance_f/core/ws/user_data_stream.dart';
import 'package:binance_f/features/portfolio/data/models/futures_account_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/futures_asset_balance.dart';
import 'package:binance_f/features/portfolio/data/models/futures_position.dart';
import 'package:binance_f/features/portfolio/data/models/portfolio_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/spot_account_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/spot_balance.dart';
import 'package:binance_f/features/portfolio/data/portfolio_repository.dart';
import 'package:binance_f/features/portfolio/providers/portfolio_provider.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker/talker.dart';

class MockPortfolioRepository extends Mock implements PortfolioRepository {}

class MockPortfolioCache extends Mock implements PortfolioCache {}

/// Fake user data stream that lets tests push events into the provider
/// without spinning up a real WS layer. We don't extend the real
/// `UserDataStream` because it's a concrete class with a heavy ctor; the
/// provider only ever calls `events`, `startSpot`, and `startFutures` on
/// it, so a duck-typed fake suffices via `implements`.
class _FakeUserDataStream implements UserDataStream {
  final StreamController<UserDataEvent> _ctl =
      StreamController<UserDataEvent>.broadcast();

  void emit(UserDataEvent event) => _ctl.add(event);

  @override
  Stream<UserDataEvent> get events => _ctl.stream;

  @override
  TaskEither<AppException, Unit> startSpot() => TaskEither.right(unit);

  @override
  TaskEither<AppException, Unit> startFutures() => TaskEither.right(unit);

  @override
  Future<void> stopAll() async {}

  @override
  Future<void> dispose() async {
    await _ctl.close();
  }

  @override
  bool get spotActive => false;

  @override
  bool get futuresActive => false;

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      super.noSuchMethod(invocation);
}

Decimal d(String v) => Decimal.parse(v);

SpotAccountSnapshot sampleSpot({DateTime? at}) => SpotAccountSnapshot(
  fetchedAt: at ?? DateTime.utc(2026, 4, 8, 12),
  balances: [
    SpotBalance(asset: 'BTC', free: d('1'), locked: Decimal.zero),
    SpotBalance(asset: 'USDT', free: d('100'), locked: Decimal.zero),
  ],
);

FuturesAccountSnapshot sampleFutures({DateTime? at}) => FuturesAccountSnapshot(
  fetchedAt: at ?? DateTime.utc(2026, 4, 8, 12),
  assets: [
    FuturesAssetBalance(
      asset: 'USDT',
      walletBalance: d('1000'),
      unrealizedProfit: Decimal.zero,
      marginBalance: d('1000'),
      availableBalance: d('1000'),
    ),
  ],
  positions: const [],
  totalWalletBalance: d('1000'),
  totalUnrealizedProfit: Decimal.zero,
  totalMarginBalance: d('1000'),
);

PortfolioSnapshot sampleSnapshot({DateTime? at}) {
  final t = at ?? DateTime.utc(2026, 4, 8, 12);
  return PortfolioSnapshot(
    spot: sampleSpot(at: t),
    futures: sampleFutures(at: t),
    totalValueInQuote: d('31100'),
    quoteAsset: 'USDT',
    fetchedAt: t,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(sampleSnapshot());
  });

  late MockPortfolioRepository repo;
  late MockPortfolioCache cache;
  late _FakeUserDataStream userStream;
  late ProviderContainer container;

  setUp(() {
    repo = MockPortfolioRepository();
    cache = MockPortfolioCache();
    userStream = _FakeUserDataStream();

    if (sl.isRegistered<PortfolioRepository>()) {
      sl.unregister<PortfolioRepository>();
    }
    if (sl.isRegistered<PortfolioCache>()) sl.unregister<PortfolioCache>();
    if (sl.isRegistered<UserDataStream>()) sl.unregister<UserDataStream>();
    if (sl.isRegistered<Talker>()) sl.unregister<Talker>();

    sl.registerSingleton<PortfolioRepository>(repo);
    sl.registerSingleton<PortfolioCache>(cache);
    sl.registerSingleton<UserDataStream>(userStream);
    sl.registerSingleton<Talker>(Talker());

    // Default save() — fire-and-forget in the provider, so just succeed.
    when(() => cache.save(any())).thenReturn(TaskEither.right(unit));

    container = ProviderContainer();
  });

  tearDown(() async {
    container.dispose();
    await userStream.dispose();
    sl
      ..unregister<PortfolioRepository>()
      ..unregister<PortfolioCache>()
      ..unregister<UserDataStream>()
      ..unregister<Talker>();
  });

  group('PortfolioNotifier.build', () {
    test('live fetch success → AsyncData with computed totals', () async {
      when(() => cache.load()).thenReturn(TaskEither.right(null));
      when(
        () => repo.getSpotAccount(),
      ).thenReturn(TaskEither.right(sampleSpot()));
      when(
        () => repo.getFuturesAccount(),
      ).thenReturn(TaskEither.right(sampleFutures()));
      when(() => repo.getAllPrices()).thenReturn(
        TaskEither.right(<String, Decimal>{'BTCUSDT': d('30000')}),
      );

      final snap = await container.read(portfolioProvider.future);

      expect(snap.quoteAsset, 'USDT');
      // 1 BTC * 30000 + 100 USDT (spot) + 1000 USDT (futures) = 31100
      expect(snap.totalValueInQuote, d('31100'));
      expect(snap.stale, isFalse);
      expect(snap.skippedAssets, isEmpty);

      // Save was invoked with the fresh snapshot.
      verify(() => cache.save(any())).called(1);
    });

    test(
      'network failure with cached snapshot → AsyncData(stale: true)',
      () async {
        when(
          () => cache.load(),
        ).thenReturn(TaskEither.right(sampleSnapshot()));
        when(() => repo.getSpotAccount()).thenReturn(
          TaskEither.left(const AppException.network(message: 'offline')),
        );
        when(() => repo.getFuturesAccount()).thenReturn(
          TaskEither.left(const AppException.network(message: 'offline')),
        );
        when(() => repo.getAllPrices()).thenReturn(
          TaskEither.left(const AppException.network(message: 'offline')),
        );

        final snap = await container.read(portfolioProvider.future);

        expect(snap.stale, isTrue);
        expect(snap.totalValueInQuote, d('31100'));
        // We never tried to overwrite the cache with a failed result.
        verifyNever(() => cache.save(any()));
      },
    );

    test(
      'network failure WITHOUT cached snapshot → AsyncError',
      () async {
        when(() => cache.load()).thenReturn(TaskEither.right(null));
        when(() => repo.getSpotAccount()).thenReturn(
          TaskEither.left(const AppException.network(message: 'offline')),
        );
        when(() => repo.getFuturesAccount()).thenReturn(
          TaskEither.left(const AppException.network(message: 'offline')),
        );
        when(() => repo.getAllPrices()).thenReturn(
          TaskEither.left(const AppException.network(message: 'offline')),
        );

        // Trigger the build and let it settle.
        container.listen(portfolioProvider, (_, _) {});
        await Future<void>.delayed(const Duration(milliseconds: 10));

        final state = container.read(portfolioProvider);
        expect(state.hasError, isTrue);
        expect(state.error, isA<NetworkException>());
      },
    );

    test(
      'non-network error always throws even if cache exists',
      () async {
        when(
          () => cache.load(),
        ).thenReturn(TaskEither.right(sampleSnapshot()));
        when(() => repo.getSpotAccount()).thenReturn(
          TaskEither.left(const AppException.auth(message: 'bad key')),
        );
        when(
          () => repo.getFuturesAccount(),
        ).thenReturn(TaskEither.right(sampleFutures()));
        when(() => repo.getAllPrices()).thenReturn(
          TaskEither.right(<String, Decimal>{'BTCUSDT': d('30000')}),
        );

        container.listen(portfolioProvider, (_, _) {});
        await Future<void>.delayed(const Duration(milliseconds: 10));

        final state = container.read(portfolioProvider);
        expect(state.hasError, isTrue);
        expect(state.error, isA<AuthException>());
      },
    );
  });

  group('PortfolioNotifier user-data merge', () {
    test('AccountUpdate event merges spot balances and clears stale', () async {
      when(() => cache.load()).thenReturn(TaskEither.right(null));
      when(
        () => repo.getSpotAccount(),
      ).thenReturn(TaskEither.right(sampleSpot()));
      when(
        () => repo.getFuturesAccount(),
      ).thenReturn(TaskEither.right(sampleFutures()));
      when(() => repo.getAllPrices()).thenReturn(
        TaskEither.right(<String, Decimal>{'BTCUSDT': d('30000')}),
      );

      // Force the initial load to land first.
      await container.read(portfolioProvider.future);

      // Push a delta: BTC drops to 0.5.
      userStream.emit(
        AccountUpdate(
          balances: [
            SpotBalance(asset: 'BTC', free: d('0.5'), locked: Decimal.zero),
          ],
        ),
      );

      // Let the broadcast event flush through the listener.
      await Future<void>.delayed(Duration.zero);

      final state = container.read(portfolioProvider).requireValue;
      final btc = state.spot.balances.firstWhere((b) => b.asset == 'BTC');
      expect(btc.free, d('0.5'));
      expect(state.stale, isFalse);
    });

    test(
      'FuturesAccountUpdate merges positions and assets',
      () async {
        when(() => cache.load()).thenReturn(TaskEither.right(null));
        when(
          () => repo.getSpotAccount(),
        ).thenReturn(TaskEither.right(sampleSpot()));
        when(
          () => repo.getFuturesAccount(),
        ).thenReturn(TaskEither.right(sampleFutures()));
        when(() => repo.getAllPrices()).thenReturn(
          TaskEither.right(<String, Decimal>{'BTCUSDT': d('30000')}),
        );

        await container.read(portfolioProvider.future);

        userStream.emit(
          FuturesAccountUpdate(
            assets: [
              FuturesAssetBalance(
                asset: 'USDT',
                walletBalance: d('900'),
                unrealizedProfit: Decimal.zero,
                marginBalance: d('900'),
                availableBalance: d('900'),
              ),
            ],
            positions: [
              FuturesPosition(
                symbol: 'BTCUSDT',
                positionAmt: d('0.1'),
                entryPrice: d('30000'),
                unrealizedProfit: d('50'),
                marginType: 'cross',
                leverage: Decimal.one,
              ),
            ],
          ),
        );

        await Future<void>.delayed(Duration.zero);

        final state = container.read(portfolioProvider).requireValue;
        expect(state.futures.assets.first.walletBalance, d('900'));
        expect(state.futures.positions, hasLength(1));
        expect(state.futures.positions.first.symbol, 'BTCUSDT');
      },
    );
  });

  group('PortfolioNotifier.refresh', () {
    test('successful refresh replaces state', () async {
      when(() => cache.load()).thenReturn(TaskEither.right(null));
      when(
        () => repo.getSpotAccount(),
      ).thenReturn(TaskEither.right(sampleSpot()));
      when(
        () => repo.getFuturesAccount(),
      ).thenReturn(TaskEither.right(sampleFutures()));
      when(() => repo.getAllPrices()).thenReturn(
        TaskEither.right(<String, Decimal>{'BTCUSDT': d('30000')}),
      );

      await container.read(portfolioProvider.future);

      // Stub a new price and refresh.
      when(() => repo.getAllPrices()).thenReturn(
        TaskEither.right(<String, Decimal>{'BTCUSDT': d('40000')}),
      );

      await container.read(portfolioProvider.notifier).refresh();

      final state = container.read(portfolioProvider).requireValue;
      // 1 BTC * 40000 + 100 USDT + 1000 USDT = 41100
      expect(state.totalValueInQuote, d('41100'));
    });
  });
}
