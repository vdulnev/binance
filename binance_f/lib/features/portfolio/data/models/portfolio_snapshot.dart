import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';
import 'futures_account_snapshot.dart';
import 'spot_account_snapshot.dart';

part 'portfolio_snapshot.freezed.dart';
part 'portfolio_snapshot.g.dart';

/// Aggregate state that the portfolio screen renders.
///
/// Combines the spot account, the futures account, and a pre-computed
/// total value in [quoteAsset] (USDT by default for Phase 3 — see the
/// TODO in `portfolio_provider.dart` about wiring this to the settings
/// table in Phase 11).
///
/// [stale] is set by the provider when the in-memory snapshot is served
/// from the Drift cache rather than a live REST fetch. The UI renders a
/// banner so the user knows they're looking at offline data.
@Freezed(toJson: true, fromJson: true)
sealed class PortfolioSnapshot with _$PortfolioSnapshot {
  const PortfolioSnapshot._();

  const factory PortfolioSnapshot({
    required SpotAccountSnapshot spot,
    required FuturesAccountSnapshot futures,
    @DecimalConverter() required Decimal totalValueInQuote,
    required String quoteAsset,
    required DateTime fetchedAt,
    @Default(false) bool stale,
    @Default(<String>[]) List<String> skippedAssets,
  }) = _PortfolioSnapshot;

  factory PortfolioSnapshot.fromJson(Map<String, dynamic> json) =>
      _$PortfolioSnapshotFromJson(json);
}
