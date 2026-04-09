import 'package:freezed_annotation/freezed_annotation.dart';

import 'spot_balance.dart';

part 'spot_account_snapshot.freezed.dart';
part 'spot_account_snapshot.g.dart';

/// Snapshot of the Binance spot account at [fetchedAt].
///
/// Only the slices Phase 3 needs are modeled: balances and (optionally)
/// commission rates. Other account-level fields (`makerCommission`,
/// `canTrade`, permissions, etc.) will be added as the trading + auth flows
/// need them.
@Freezed(toJson: true, fromJson: true)
sealed class SpotAccountSnapshot with _$SpotAccountSnapshot {
  const SpotAccountSnapshot._();

  const factory SpotAccountSnapshot({
    required DateTime fetchedAt,
    required List<SpotBalance> balances,
    Map<String, String>? commissionRates,
  }) = _SpotAccountSnapshot;

  factory SpotAccountSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SpotAccountSnapshotFromJson(json);
}
