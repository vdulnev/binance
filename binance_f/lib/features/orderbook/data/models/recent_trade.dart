import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'recent_trade.freezed.dart';
part 'recent_trade.g.dart';

/// A single executed trade from `GET /api/v3/trades` or the
/// `<symbol>@trade` WebSocket stream.
@Freezed(toJson: true, fromJson: true)
sealed class RecentTrade with _$RecentTrade {
  const RecentTrade._();

  const factory RecentTrade({
    required int id,
    @DecimalConverter() required Decimal price,
    @DecimalConverter() required Decimal qty,
    required int time,
    required bool isBuyerMaker,
  }) = _RecentTrade;

  factory RecentTrade.fromJson(Map<String, dynamic> json) =>
      _$RecentTradeFromJson(json);

  /// Whether the taker (aggressor) was a buyer. When `isBuyerMaker` is
  /// true, the maker placed the buy limit and the taker sold into it,
  /// so the trade prints red (sell). When false, the trade prints green
  /// (buy).
  bool get isBuy => !isBuyerMaker;

  DateTime get timestamp =>
      DateTime.fromMillisecondsSinceEpoch(time, isUtc: true);
}
