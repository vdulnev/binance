import 'package:freezed_annotation/freezed_annotation.dart';

import 'symbol_filter.dart';

part 'symbol_info.freezed.dart';
part 'symbol_info.g.dart';

/// A trading symbol from `GET /api/v3/exchangeInfo` or
/// `GET /fapi/v1/exchangeInfo`.
///
/// Contains the base/quote assets, trading status, and the exchange
/// filters needed for client-side order validation (Phase 5/6).
@Freezed(toJson: true, fromJson: true)
sealed class SymbolInfo with _$SymbolInfo {
  const SymbolInfo._();

  const factory SymbolInfo({
    required String symbol,
    required String baseAsset,
    required String quoteAsset,
    required String status,
    required String market,
    @Default(<SymbolFilter>[]) List<SymbolFilter> filters,
  }) = _SymbolInfo;

  factory SymbolInfo.fromJson(Map<String, dynamic> json) =>
      _$SymbolInfoFromJson(json);

  /// Human-readable display name: `BTC/USDT`.
  String get displayName => '$baseAsset/$quoteAsset';

  /// Whether this symbol is currently active for trading.
  bool get isTrading => status == 'TRADING';
}
