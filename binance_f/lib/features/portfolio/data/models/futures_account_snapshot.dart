import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';
import 'futures_asset_balance.dart';
import 'futures_position.dart';

part 'futures_account_snapshot.freezed.dart';
part 'futures_account_snapshot.g.dart';

/// Snapshot of the Binance USDⓈ-M futures account at [fetchedAt].
///
/// `GET /fapi/v2/account` returns totals pre-computed on the server; we
/// store them verbatim in [totalWalletBalance] / [totalUnrealizedProfit] /
/// [totalMarginBalance] rather than re-summing — Binance is authoritative.
@Freezed(toJson: true, fromJson: true)
sealed class FuturesAccountSnapshot with _$FuturesAccountSnapshot {
  const FuturesAccountSnapshot._();

  const factory FuturesAccountSnapshot({
    required DateTime fetchedAt,
    required List<FuturesAssetBalance> assets,
    required List<FuturesPosition> positions,
    @DecimalConverter() required Decimal totalWalletBalance,
    @DecimalConverter() required Decimal totalUnrealizedProfit,
    @DecimalConverter() required Decimal totalMarginBalance,
  }) = _FuturesAccountSnapshot;

  /// Empty snapshot used when the API key lacks futures permission (EC-2).
  factory FuturesAccountSnapshot.empty() => FuturesAccountSnapshot(
    fetchedAt: DateTime.now().toUtc(),
    assets: const [],
    positions: const [],
    totalWalletBalance: Decimal.zero,
    totalUnrealizedProfit: Decimal.zero,
    totalMarginBalance: Decimal.zero,
  );

  bool get isEmpty =>
      assets.isEmpty && positions.isEmpty && totalWalletBalance == Decimal.zero;

  factory FuturesAccountSnapshot.fromJson(Map<String, dynamic> json) =>
      _$FuturesAccountSnapshotFromJson(json);
}
