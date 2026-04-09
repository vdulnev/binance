import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/auth/session_manager.dart';
import '../../../core/models/app_exception.dart';
import '../../auth/data/auth_repository.dart' show DioProvider;
import 'models/futures_account_snapshot.dart';
import 'models/futures_asset_balance.dart';
import 'models/futures_position.dart';
import 'models/spot_account_snapshot.dart';
import 'models/spot_balance.dart';

/// Data access for portfolio state: spot account, futures account, and
/// the spot ticker price map used to value the portfolio in a single quote
/// asset.
///
/// Every method returns a `TaskEither<AppException, T>` — failures are
/// values, not thrown exceptions. See
/// `lib/core/errors/error_events.dart` for how notifiers fold the `Left`
/// branch into `AsyncError` for the global error observer.
abstract class PortfolioRepository {
  /// `GET /api/v3/account` (signed). Returns a [SpotAccountSnapshot] with
  /// only the non-zero balances.
  TaskEither<AppException, SpotAccountSnapshot> getSpotAccount();

  /// `GET /fapi/v2/account` (signed). Returns a [FuturesAccountSnapshot]
  /// with only the non-zero assets and open positions.
  TaskEither<AppException, FuturesAccountSnapshot> getFuturesAccount();

  /// `GET /api/v3/ticker/price` (public). Returns `{ symbol → price }`
  /// decoded as [Decimal]. Used by the total-value calculator to roll
  /// every asset into a single quote currency.
  TaskEither<AppException, Map<String, Decimal>> getAllPrices();
}

class BinancePortfolioRepository implements PortfolioRepository {
  BinancePortfolioRepository({
    required DioProvider spotDio,
    required DioProvider futuresDio,
    SessionManager? sessionManager,
  }) : _spot = spotDio,
       _futures = futuresDio,
       _sessionManager = sessionManager;

  final DioProvider _spot;
  final DioProvider _futures;
  final SessionManager? _sessionManager;

  // ---------------------------------------------------------------------
  // Spot account
  // ---------------------------------------------------------------------

  @override
  TaskEither<AppException, SpotAccountSnapshot> getSpotAccount() {
    // EC-15: register a CancelToken with SessionManager so logout
    // mid-request aborts the call rather than letting it hit the server
    // with a stale signature. Cleanup via `.bimap` so both branches
    // unregister — no try/finally.
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, SpotAccountSnapshot>.tryCatch(() async {
      final response = await _spot().get<Map<String, dynamic>>(
        '/api/v3/account',
        queryParameters: <String, dynamic>{'omitZeroBalances': 'true'},
        cancelToken: cancelToken,
      );

      final data = response.data ?? const <String, dynamic>{};
      final rawBalances =
          (data['balances'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

      final parsed = rawBalances
          .map(SpotBalance.fromJson)
          .where((b) => !b.isZero)
          .toList(growable: false);

      // `commissionRates` is object-shaped in Binance responses. It's not
      // load-bearing for Phase 3 — include it so later phases can read it
      // without another round-trip.
      final rates = data['commissionRates'];
      Map<String, String>? commissionRates;
      if (rates is Map<String, dynamic>) {
        commissionRates = rates.map((k, v) => MapEntry(k, v.toString()));
      }

      return SpotAccountSnapshot(
        fetchedAt: DateTime.now().toUtc(),
        balances: parsed,
        commissionRates: commissionRates,
      );
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  // ---------------------------------------------------------------------
  // Futures account
  // ---------------------------------------------------------------------

  @override
  TaskEither<AppException, FuturesAccountSnapshot> getFuturesAccount() {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, FuturesAccountSnapshot>.tryCatch(() async {
      final response = await _futures().get<Map<String, dynamic>>(
        '/fapi/v2/account',
        cancelToken: cancelToken,
      );

      final data = response.data ?? const <String, dynamic>{};

      final rawAssets =
          (data['assets'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
      final assets = rawAssets
          .map(FuturesAssetBalance.fromJson)
          .where((a) => !a.isZero)
          .toList(growable: false);

      final rawPositions =
          (data['positions'] as List?)?.cast<Map<String, dynamic>>() ??
          const [];
      final positions = rawPositions
          .map(FuturesPosition.fromJson)
          .where((p) => p.isOpen)
          .toList(growable: false);

      Decimal dec(String key) => Decimal.parse((data[key] ?? '0').toString());

      return FuturesAccountSnapshot(
        fetchedAt: DateTime.now().toUtc(),
        assets: assets,
        positions: positions,
        totalWalletBalance: dec('totalWalletBalance'),
        totalUnrealizedProfit: dec('totalUnrealizedProfit'),
        totalMarginBalance: dec('totalMarginBalance'),
      );
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  // ---------------------------------------------------------------------
  // Ticker prices
  // ---------------------------------------------------------------------

  @override
  TaskEither<AppException, Map<String, Decimal>> getAllPrices() {
    final cancelToken = CancelToken();
    _sessionManager?.registerCancelToken(cancelToken);

    return TaskEither<AppException, Map<String, Decimal>>.tryCatch(() async {
      final response = await _spot().get<List<dynamic>>(
        '/api/v3/ticker/price',
        cancelToken: cancelToken,
      );
      final list = response.data ?? const [];

      final out = <String, Decimal>{};
      for (final entry in list) {
        if (entry is Map<String, dynamic>) {
          final symbol = entry['symbol'] as String?;
          final price = entry['price'];
          if (symbol == null || price == null) continue;
          out[symbol] = Decimal.parse(price.toString());
        }
      }
      return out;
    }, _toAppException).bimap(_cleanup(cancelToken), _cleanup(cancelToken));
  }

  // ---------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------

  /// Returns a closure usable as the left/right arm of `.bimap` that
  /// unregisters [token] and passes the original value through. This is
  /// the fpdart equivalent of a `try/finally` cleanup block.
  T Function(T) _cleanup<T>(CancelToken token) {
    return (value) {
      _sessionManager?.unregisterCancelToken(token);
      return value;
    };
  }

  AppException _toAppException(Object err, StackTrace _) {
    if (err is AppException) return err;
    if (err is DioException && err.error is AppException) {
      return err.error! as AppException;
    }
    return AppException.unknown(message: err.toString());
  }
}
