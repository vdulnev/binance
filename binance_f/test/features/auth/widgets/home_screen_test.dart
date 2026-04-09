import 'dart:async';

import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/env/env.dart';
import 'package:binance_f/core/env/env_manager.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/auth/providers/auth_provider.dart';
import 'package:binance_f/features/auth/providers/auth_state.dart';
import 'package:binance_f/features/auth/widgets/home_screen.dart';
import 'package:binance_f/features/favorites/data/models/favorite_symbol.dart';
import 'package:binance_f/features/favorites/providers/favorites_provider.dart';
import 'package:binance_f/features/markets/data/models/symbol_info.dart';
import 'package:binance_f/features/markets/data/models/ticker_24h.dart';
import 'package:binance_f/features/markets/providers/exchange_info_provider.dart';
import 'package:binance_f/features/markets/providers/tickers_provider.dart';
import 'package:binance_f/features/portfolio/data/models/futures_account_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/futures_asset_balance.dart';
import 'package:binance_f/features/portfolio/data/models/futures_position.dart';
import 'package:binance_f/features/portfolio/data/models/portfolio_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/spot_account_snapshot.dart';
import 'package:binance_f/features/portfolio/data/models/spot_balance.dart';
import 'package:binance_f/features/portfolio/providers/portfolio_provider.dart';
import 'package:binance_f/features/portfolio/widgets/stale_banner.dart';
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';

/// Recording auth notifier used to assert the logout button dispatches
/// the right action. Mirrors the pattern in `login_screen_test.dart`.
class _RecordingAuthNotifier extends Notifier<AuthState>
    implements AuthNotifier {
  int logoutCalls = 0;

  @override
  AuthState build() => const AuthState.authenticated();

  @override
  Future<void> login({
    required String apiKey,
    required String apiSecret,
    required BinanceEnv env,
  }) async {}

  @override
  Future<void> logout() async {
    logoutCalls++;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Stub portfolio notifier that lets the test seed any [AsyncValue] into
/// the provider. `refresh()` bumps a counter so the test can verify the
/// refresh button is wired to the notifier.
class _FakePortfolioNotifier extends AsyncNotifier<PortfolioSnapshot>
    implements PortfolioNotifier {
  _FakePortfolioNotifier(this._initial);

  final AsyncValue<PortfolioSnapshot> _initial;
  int refreshCalls = 0;

  @override
  Future<PortfolioSnapshot> build() async {
    // Directly set the state so the widget immediately sees the
    // seeded value (data / error / loading) without relying on
    // future-completion timing that differs across FakeAsync zones.
    state = _initial;
    // Return a never-completing future so Riverpod doesn't overwrite
    // the state we just set.
    return Completer<PortfolioSnapshot>().future;
  }

  @override
  Future<void> refresh() async {
    refreshCalls++;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Stub favorites notifier so MarketsTab doesn't hit DI.
class _FakeFavoritesNotifier extends AsyncNotifier<List<FavoriteSymbol>>
    implements FavoritesNotifier {
  @override
  Future<List<FavoriteSymbol>> build() async => [];

  @override
  Future<void> add(String symbol, String market) async {}

  @override
  Future<void> remove(String symbol, String market) async {}

  @override
  Future<void> reorder(List<FavoriteSymbol> ordered) async {}

  @override
  Future<bool> isFavorite(String symbol, String market) async => false;
}

/// Stub tickers notifier so MarketsTab doesn't hit DI.
class _FakeTickersNotifier extends AsyncNotifier<Map<String, Ticker24h>>
    implements TickersNotifier {
  @override
  Future<Map<String, Ticker24h>> build() async => {};

  @override
  Future<void> refresh() async {}
}

Decimal d(String v) => Decimal.parse(v);

PortfolioSnapshot buildSnapshot({bool stale = false}) {
  final t = DateTime.utc(2026, 4, 8, 12);
  return PortfolioSnapshot(
    spot: SpotAccountSnapshot(
      fetchedAt: t,
      balances: [
        SpotBalance(asset: 'BTC', free: d('1.5'), locked: Decimal.zero),
        SpotBalance(asset: 'USDT', free: d('100'), locked: Decimal.zero),
      ],
    ),
    futures: FuturesAccountSnapshot(
      fetchedAt: t,
      assets: [
        FuturesAssetBalance(
          asset: 'USDT',
          walletBalance: d('1000'),
          unrealizedProfit: Decimal.zero,
          marginBalance: d('1000'),
          availableBalance: d('1000'),
        ),
      ],
      positions: [
        FuturesPosition(
          symbol: 'BTCUSDT',
          positionAmt: d('0.1'),
          entryPrice: d('30000'),
          unrealizedProfit: d('50'),
          marginType: 'cross',
          leverage: d('10'),
        ),
      ],
      totalWalletBalance: d('1000'),
      totalUnrealizedProfit: d('50'),
      totalMarginBalance: d('1050'),
    ),
    totalValueInQuote: d('46100'),
    quoteAsset: 'USDT',
    fetchedAt: t,
    stale: stale,
  );
}

void main() {
  setUp(() {
    if (sl.isRegistered<EnvManager>()) sl.unregister<EnvManager>();
    if (sl.isRegistered<Talker>()) sl.unregister<Talker>();
    sl.registerSingleton<Talker>(Talker());
    sl.registerSingleton<EnvManager>(
      EnvManager(talker: sl<Talker>(), dioFactory: (_, _) => Dio()),
    );
  });

  tearDown(() {
    sl
      ..unregister<EnvManager>()
      ..unregister<Talker>();
  });

  Future<({_RecordingAuthNotifier auth, _FakePortfolioNotifier portfolio})>
  pumpHome(
    WidgetTester tester, {
    required AsyncValue<PortfolioSnapshot> portfolioState,
  }) async {
    final auth = _RecordingAuthNotifier();
    final portfolio = _FakePortfolioNotifier(portfolioState);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(() => auth),
          portfolioProvider.overrideWith(() => portfolio),
          // Phase 4: MarketsTab is now in the IndexedStack and builds
          // even when not visible. Override its providers so they don't
          // hit the DI container.
          favoritesProvider.overrideWith(_FakeFavoritesNotifier.new),
          tickersProvider.overrideWith2((_) => _FakeTickersNotifier()),
          exchangeInfoProvider.overrideWith(
            (ref, market) async => <SymbolInfo>[],
          ),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );
    // Run microtasks in a real async zone so the fake notifiers'
    // `await Future.microtask` resolves, then pump to rebuild.
    // Multiple rounds are needed because Riverpod processes async
    // state transitions across separate microtask ticks.
    for (var i = 0; i < 3; i++) {
      await tester.runAsync(() async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
      });
      await tester.pump();
    }
    return (auth: auth, portfolio: portfolio);
  }

  group('HomeScreen rendering', () {
    testWidgets('shows loading indicator while portfolio is loading', (
      tester,
    ) async {
      await pumpHome(
        tester,
        portfolioState: const AsyncLoading<PortfolioSnapshot>(),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders portfolio body on data', (tester) async {
      await pumpHome(tester, portfolioState: AsyncData(buildSnapshot()));

      // Header shows the total value.
      expect(find.textContaining('46100'), findsOneWidget);
      // Spot balance row is present.
      expect(find.text('BTC'), findsWidgets);
      // Stale banner is NOT present on fresh data.
      expect(find.byType(StaleBanner), findsNothing);
    });

    testWidgets('shows stale banner when snapshot is stale', (tester) async {
      await pumpHome(
        tester,
        portfolioState: AsyncData(buildSnapshot(stale: true)),
      );

      expect(find.byType(StaleBanner), findsOneWidget);
    });

    testWidgets(
      'error view renders the AppException.displayMessage and a Retry button',
      (tester) async {
        await pumpHome(
          tester,
          portfolioState: AsyncError<PortfolioSnapshot>(
            const AppException.network(),
            StackTrace.empty,
          ),
        );

        // The error text is composed from
        // `NetworkException.displayMessage`. It contains a distinctive
        // phrase — match on that to avoid coupling to theme whitespace.
        expect(find.textContaining('Network error'), findsOneWidget);
        expect(find.text('Retry'), findsOneWidget);
      },
    );
  });

  group('HomeScreen actions', () {
    testWidgets('refresh button calls notifier.refresh', (tester) async {
      final handles = await pumpHome(
        tester,
        portfolioState: AsyncData(buildSnapshot()),
      );

      await tester.tap(find.byKey(const ValueKey('portfolio-refresh')));
      await tester.pump();

      expect(handles.portfolio.refreshCalls, 1);
    });

    testWidgets('logout button calls auth.logout', (tester) async {
      final handles = await pumpHome(
        tester,
        portfolioState: AsyncData(buildSnapshot()),
      );

      await tester.tap(find.byKey(const ValueKey('portfolio-logout')));
      await tester.pump();

      expect(handles.auth.logoutCalls, 1);
    });
  });
}
