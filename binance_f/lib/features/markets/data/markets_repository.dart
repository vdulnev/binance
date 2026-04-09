import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/db/app_database.dart';
import '../../../core/models/app_exception.dart';
import '../../auth/data/auth_repository.dart' show DioProvider;
import 'models/symbol_filter.dart';
import 'models/symbol_info.dart';
import 'models/ticker_24h.dart';

/// Data access for market-wide information: exchange symbols and 24h
/// tickers, for both spot and futures markets.
///
/// All methods return `TaskEither<AppException, T>` — failures are
/// values, not thrown exceptions.
abstract class MarketsRepository {
  /// Fetches the full symbol list from `GET /api/v3/exchangeInfo` (spot)
  /// or `GET /fapi/v1/exchangeInfo` (futures) and caches each symbol
  /// into the Drift `cached_symbols` table.
  TaskEither<AppException, List<SymbolInfo>> getExchangeInfo({
    required String market,
  });

  /// Fetches 24h ticker statistics for every symbol on the given market.
  TaskEither<AppException, List<Ticker24h>> get24hTickers({
    required String market,
  });
}

class BinanceMarketsRepository implements MarketsRepository {
  BinanceMarketsRepository({
    required DioProvider spotDio,
    required DioProvider futuresDio,
    required AppDatabase database,
  }) : _spot = spotDio,
       _futures = futuresDio,
       _db = database;

  final DioProvider _spot;
  final DioProvider _futures;
  final AppDatabase _db;

  Dio _dioFor(String market) => market == 'futures' ? _futures() : _spot();

  String _exchangeInfoPath(String market) =>
      market == 'futures' ? '/fapi/v1/exchangeInfo' : '/api/v3/exchangeInfo';

  String _tickerPath(String market) =>
      market == 'futures' ? '/fapi/v1/ticker/24hr' : '/api/v3/ticker/24hr';

  // -------------------------------------------------------------------
  // Exchange info
  // -------------------------------------------------------------------

  @override
  TaskEither<AppException, List<SymbolInfo>> getExchangeInfo({
    required String market,
  }) {
    return TaskEither<AppException, List<SymbolInfo>>.tryCatch(() async {
      final response = await _dioFor(
        market,
      ).get<Map<String, dynamic>>(_exchangeInfoPath(market));

      final data = response.data ?? const <String, dynamic>{};
      final rawSymbols =
          (data['symbols'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

      final symbols = rawSymbols
          .map((raw) {
            final rawFilters =
                (raw['filters'] as List?)?.cast<Map<String, dynamic>>() ??
                const [];
            final filters = rawFilters
                .map(SymbolFilter.fromJson)
                .toList(growable: false);

            return SymbolInfo(
              symbol: raw['symbol'] as String,
              baseAsset: raw['baseAsset'] as String,
              quoteAsset: raw['quoteAsset'] as String,
              status: (raw['status'] ?? raw['contractStatus'] ?? '') as String,
              market: market,
              filters: filters,
            );
          })
          .toList(growable: false);

      // Cache into Drift — fire-and-forget, errors are swallowed so the
      // UI always gets the fresh list even if Drift write fails.
      _cacheSymbols(symbols, market);

      return symbols;
    }, _toAppException);
  }

  void _cacheSymbols(List<SymbolInfo> symbols, String market) {
    final now = DateTime.now().toUtc();
    for (final s in symbols) {
      _db
          .into(_db.cachedSymbols)
          .insert(
            CachedSymbolsCompanion.insert(
              symbol: s.symbol,
              market: market,
              baseAsset: s.baseAsset,
              quoteAsset: s.quoteAsset,
              status: s.status,
              filtersJson: jsonEncode(
                s.filters.map((f) => f.toJson()).toList(),
              ),
              updatedAt: now,
            ),
            mode: InsertMode.insertOrReplace,
          );
    }
  }

  // -------------------------------------------------------------------
  // 24h tickers
  // -------------------------------------------------------------------

  @override
  TaskEither<AppException, List<Ticker24h>> get24hTickers({
    required String market,
  }) {
    return TaskEither<AppException, List<Ticker24h>>.tryCatch(() async {
      final response = await _dioFor(
        market,
      ).get<List<dynamic>>(_tickerPath(market));
      final list = response.data ?? const [];
      return list
          .whereType<Map<String, dynamic>>()
          .map(Ticker24h.fromJson)
          .toList(growable: false);
    }, _toAppException);
  }
}

AppException _toAppException(Object err, StackTrace _) {
  if (err is AppException) return err;
  if (err is DioException && err.error is AppException) {
    return err.error! as AppException;
  }
  return AppException.unknown(message: err.toString());
}
