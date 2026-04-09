import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talker/talker.dart';

import '../../../core/db/portfolio_cache.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/models/app_exception.dart';
import '../../../core/ws/user_data_event.dart';
import '../../../core/ws/user_data_stream.dart';
import '../data/models/futures_account_snapshot.dart';
import '../data/models/futures_asset_balance.dart';
import '../data/models/futures_position.dart';
import '../data/models/portfolio_snapshot.dart';
import '../data/models/spot_account_snapshot.dart';
import '../data/models/spot_balance.dart';
import '../data/portfolio_repository.dart';
import '../domain/total_value_calculator.dart';

/// Phase 3 hard-codes USDT as the portfolio quote asset. Phase 11 wires
/// this to the settings Drift table so the user can pick a different
/// quote. Leave the constant referenced in exactly one place so the
/// grep-for-TODO is easy later.
// TODO(Phase 11): read quote asset from the settings table.
const String kDefaultQuoteAsset = 'USDT';

/// `AsyncNotifier` that backs the portfolio screen.
///
/// ### Load order
/// 1. On `build()`, emit the Drift-cached snapshot immediately with
///    `stale=true` (if present) so the UI renders something even before
///    the live fetch resolves. `AsyncNotifier.build` returns the first
///    non-cached value, so the cached emit happens via
///    `ref.read(self.notifier)` ... actually we emit via `state = ...`
///    inside `build` by reaching into the Future result.
/// 2. Fetch spot + futures accounts and the price map in parallel,
///    compute the total value, persist the fresh snapshot, and emit it
///    as `AsyncData`.
/// 3. Start both user data streams and merge live updates into the
///    current snapshot so balances stay in sync without a manual refresh.
///
/// ### Offline behavior (FR-9)
/// When the live fetch returns `Left(NetworkException)` **and** a cached
/// snapshot exists, the notifier emits `AsyncData(cached.copyWith(
/// stale: true))` instead of `AsyncError`. Only when there is no cache at
/// all does the failure escalate to `AsyncError` for the global error
/// observer to handle.
final portfolioProvider =
    AsyncNotifierProvider<PortfolioNotifier, PortfolioSnapshot>(
      PortfolioNotifier.new,
    );

class PortfolioNotifier extends AsyncNotifier<PortfolioSnapshot> {
  // `late` (not `late final`) — Riverpod may rebuild and reassign these.
  late PortfolioRepository _repo;
  late PortfolioCache _cache;
  late UserDataStream _userStream;
  late Talker _talker;

  StreamSubscription<UserDataEvent>? _sub;

  @override
  Future<PortfolioSnapshot> build() async {
    _repo = sl<PortfolioRepository>();
    _cache = sl<PortfolioCache>();
    _userStream = sl<UserDataStream>();
    _talker = sl<Talker>();

    ref.onDispose(() {
      _sub?.cancel();
      _sub = null;
    });

    // 1. Try to load the cached snapshot. Emit it immediately (stale) if
    //    present so the UI has something to render before the live fetch
    //    resolves.
    final cachedResult = await _cache.load().run();
    final cached = cachedResult.getOrElse((_) => null);

    // 2. Run the live fetch. If it fails AND we have a cache, emit the
    //    stale cache. If both fail, propagate the live-fetch error.
    final freshResult = await _loadFresh().run();

    return freshResult.fold(
      (err) {
        if (cached != null && err is NetworkException) {
          _talker.info(
            'PortfolioNotifier: live fetch failed with network error; '
            'serving cached snapshot as stale',
          );
          _startUserStreamInBackground();
          return cached.copyWith(stale: true);
        }
        _talker.error('PortfolioNotifier: live fetch failed', err);
        // Non-network errors or cache miss: escalate.
        throw err;
      },
      (snapshot) {
        // Persist + start streams. `save` is fire-and-forget so the UI
        // isn't blocked on Drift write latency.
        _cache.save(snapshot).run();
        _startUserStreamInBackground();
        return snapshot;
      },
    );
  }

  /// Re-run the full load chain and push the result into `state`.
  /// Called by the refresh button on the portfolio screen.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard<PortfolioSnapshot>(() async {
      final result = await _loadFresh().run();
      return result.fold(
        (err) async {
          final cachedResult = await _cache.load().run();
          final cached = cachedResult.getOrElse((_) => null);
          if (cached != null && err is NetworkException) {
            return cached.copyWith(stale: true);
          }
          throw err;
        },
        (snapshot) async {
          _cache.save(snapshot).run();
          return snapshot;
        },
      );
    });
  }

  /// The fpdart chain that fetches the three inputs in parallel and
  /// rolls them into a `PortfolioSnapshot`.
  ///
  /// Spot + prices are required; futures is **best-effort**. If the API key
  /// lacks futures permission (`-2015` / Auth), futures degrades to an empty
  /// snapshot and the portfolio loads spot-only (spec EC-2).
  TaskEither<AppException, PortfolioSnapshot> _loadFresh() {
    return TaskEither<AppException, PortfolioSnapshot>(() async {
      final spotTask = _repo.getSpotAccount().run();
      final futuresTask = _repo.getFuturesAccount().run();
      final pricesTask = _repo.getAllPrices().run();

      final results = await Future.wait([spotTask, futuresTask, pricesTask]);

      final spotEither =
          results[0] as Either<AppException, SpotAccountSnapshot>;
      final futuresEither =
          results[1] as Either<AppException, FuturesAccountSnapshot>;
      final pricesEither =
          results[2] as Either<AppException, Map<String, Decimal>>;

      // Spot + prices are required — first Left propagates.
      // Futures is best-effort: Auth/permission errors degrade to empty
      // snapshot (EC-2) rather than killing the entire portfolio load.
      final futures = futuresEither.getOrElse((err) {
        _talker.warning('Futures account unavailable — showing spot only', err);
        return FuturesAccountSnapshot.empty();
      });

      return spotEither.flatMap(
        (spot) => pricesEither.map((prices) {
          final totals = computeTotalInQuote(
            spotBalances: spot.balances,
            futuresAssets: futures.assets,
            prices: prices,
            quoteAsset: kDefaultQuoteAsset,
          );
          return PortfolioSnapshot(
            spot: spot,
            futures: futures,
            totalValueInQuote: totals.total,
            quoteAsset: totals.quoteAsset,
            fetchedAt: DateTime.now().toUtc(),
            skippedAssets: totals.skippedAssets,
          );
        }),
      );
    });
  }

  /// Kick off both user data streams and wire their events into the
  /// current snapshot. Errors during start are logged but never block
  /// the UI — the stream will keep retrying via `WsClient`'s backoff.
  void _startUserStreamInBackground() {
    if (_sub != null) return;
    _sub = _userStream.events.listen(_onUserEvent);
    _userStream.startSpot().run().then((r) {
      r.match(
        (err) => _talker.error('UserDataStream.startSpot failed', err),
        (_) => _talker.debug('UserDataStream: spot started'),
      );
    });
    // Only start the futures stream if we actually have futures data.
    // If the API key lacks futures permission the stream will just fail
    // with -2015 on listenKey creation — skip it entirely.
    final currentSnapshot = state.value;
    if (currentSnapshot != null && !currentSnapshot.futures.isEmpty) {
      _userStream.startFutures().run().then((r) {
        r.match(
          (err) => _talker.error('UserDataStream.startFutures failed', err),
          (_) => _talker.debug('UserDataStream: futures started'),
        );
      });
    }
  }

  /// Merge a single user data event into the current snapshot so the UI
  /// updates without a REST refresh.
  void _onUserEvent(UserDataEvent event) {
    final current = state.value;
    if (current == null) return;

    switch (event) {
      case AccountUpdate(:final balances):
        final merged = _mergeSpotBalances(current.spot.balances, balances);
        state = AsyncData(
          current.copyWith(
            spot: current.spot.copyWith(
              fetchedAt: DateTime.now().toUtc(),
              balances: merged,
            ),
            stale: false,
          ),
        );
      case FuturesAccountUpdate(:final assets, :final positions):
        final mergedAssets = _mergeFuturesAssets(
          current.futures.assets,
          assets,
        );
        final mergedPositions = _mergeFuturesPositions(
          current.futures.positions,
          positions,
        );
        state = AsyncData(
          current.copyWith(
            futures: current.futures.copyWith(
              fetchedAt: DateTime.now().toUtc(),
              assets: mergedAssets,
              positions: mergedPositions,
            ),
            stale: false,
          ),
        );
    }
  }

  List<SpotBalance> _mergeSpotBalances(
    List<SpotBalance> current,
    List<SpotBalance> delta,
  ) {
    final byAsset = {for (final b in current) b.asset: b};
    for (final d in delta) {
      if (d.isZero) {
        byAsset.remove(d.asset);
      } else {
        byAsset[d.asset] = d;
      }
    }
    final merged = byAsset.values.toList()
      ..sort((a, b) => a.asset.compareTo(b.asset));
    return merged;
  }

  List<FuturesAssetBalance> _mergeFuturesAssets(
    List<FuturesAssetBalance> current,
    List<FuturesAssetBalance> delta,
  ) {
    final byAsset = {for (final a in current) a.asset: a};
    for (final d in delta) {
      if (d.isZero) {
        byAsset.remove(d.asset);
      } else {
        byAsset[d.asset] = d;
      }
    }
    final merged = byAsset.values.toList()
      ..sort((a, b) => a.asset.compareTo(b.asset));
    return merged;
  }

  List<FuturesPosition> _mergeFuturesPositions(
    List<FuturesPosition> current,
    List<FuturesPosition> delta,
  ) {
    final bySymbol = {for (final p in current) p.symbol: p};
    for (final d in delta) {
      if (!d.isOpen) {
        bySymbol.remove(d.symbol);
      } else {
        bySymbol[d.symbol] = d;
      }
    }
    final merged = bySymbol.values.toList()
      ..sort((a, b) => a.symbol.compareTo(b.symbol));
    return merged;
  }
}
