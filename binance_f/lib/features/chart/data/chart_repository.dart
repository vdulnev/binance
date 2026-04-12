import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:k_chart_plus/k_chart_plus.dart';

import '../../../core/models/app_exception.dart';
import '../../auth/data/auth_repository.dart' show DioProvider;

/// Data access for historical klines (candlesticks).
abstract class ChartRepository {
  /// Fetches historical klines from `GET /api/v3/klines` (spot)
  /// or `GET /fapi/v1/klines` (futures).
  TaskEither<AppException, List<KLineEntity>> getKlines({
    required String symbol,
    required String market,
    required String interval,
    int limit = 500,
  });
}

class BinanceChartRepository implements ChartRepository {
  BinanceChartRepository({
    required DioProvider spotDio,
    required DioProvider futuresDio,
  }) : _spot = spotDio,
       _futures = futuresDio;

  final DioProvider _spot;
  final DioProvider _futures;

  Dio _dioFor(String market) => market == 'futures' ? _futures() : _spot();

  String _klinesPath(String market) =>
      market == 'futures' ? '/fapi/v1/klines' : '/api/v3/klines';

  @override
  TaskEither<AppException, List<KLineEntity>> getKlines({
    required String symbol,
    required String market,
    required String interval,
    int limit = 500,
  }) {
    return TaskEither<AppException, List<KLineEntity>>.tryCatch(
      () async {
        final response = await _dioFor(market).get<List<dynamic>>(
          _klinesPath(market),
          queryParameters: {
            'symbol': symbol,
            'interval': interval,
            'limit': limit,
          },
        );

        final data = response.data ?? const [];
        return data.map((item) {
          final row = item as List<dynamic>;
          // Binance Klines:
          // [
          //   1499040000000,      // Open time
          //   "0.01634790",       // Open
          //   "0.80000000",       // High
          //   "0.01575800",       // Low
          //   "0.01577100",       // Close
          //   "148976.11427815",  // Volume
          //   1499644799999,      // Close time
          //   "2434.19055334",    // Quote asset volume
          //   308,                // Number of trades
          //   "1756.87402397",    // Taker buy base asset volume
          //   "28.46694368",      // Taker buy quote asset volume
          //   "17928899.62484339" // Ignore
          // ]
          return KLineEntity.fromCustom(
            open: double.parse(row[1].toString()),
            high: double.parse(row[2].toString()),
            low: double.parse(row[3].toString()),
            close: double.parse(row[4].toString()),
            vol: double.parse(row[5].toString()),
            time: row[0] as int,
          );
        }).toList();
      },
      (error, stackTrace) {
        if (error is AppException) return error;
        if (error is DioException && error.error is AppException) {
          return error.error! as AppException;
        }
        return AppException.unknown(message: error.toString());
      },
    );
  }
}
