import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'kline_update.freezed.dart';
part 'kline_update.g.dart';

/// A single kline (candlestick) update from the `<symbol>@kline_<interval>`
/// WebSocket stream.
///
/// Phase 7 will wire this into the chart widget. Phase 4 only parses and
/// streams it.
@Freezed(toJson: true, fromJson: true)
sealed class KlineUpdate with _$KlineUpdate {
  const factory KlineUpdate({
    required String symbol,
    required String interval,
    required int openTime,
    @DecimalConverter() required Decimal open,
    @DecimalConverter() required Decimal high,
    @DecimalConverter() required Decimal low,
    @DecimalConverter() required Decimal close,
    @DecimalConverter() required Decimal volume,
    required bool isClosed,
  }) = _KlineUpdate;

  factory KlineUpdate.fromJson(Map<String, dynamic> json) =>
      _$KlineUpdateFromJson(json);
}
