import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/portfolio/data/models/futures_asset_balance.dart';
import '../../features/portfolio/data/models/futures_position.dart';
import '../../features/portfolio/data/models/spot_balance.dart';

part 'user_data_event.freezed.dart';

/// Phase 3 slice of events emitted by the user data stream.
///
/// Only the portfolio-relevant events are modeled here — Binance also
/// pushes order / execution / margin-call events via the same stream but
/// those arrive in Phases 5 and 6 alongside the trading UI.
@freezed
sealed class UserDataEvent with _$UserDataEvent {
  const UserDataEvent._();

  /// Spot `outboundAccountPosition` — snapshot of the balances that changed
  /// on this account. Binance sends the delta, not the full account.
  const factory UserDataEvent.accountUpdate({
    required List<SpotBalance> balances,
  }) = AccountUpdate;

  /// Futures `ACCOUNT_UPDATE` — delta of wallet assets and positions.
  /// Binance only includes the affected rows; the provider merges them
  /// into the existing snapshot rather than replacing it wholesale.
  const factory UserDataEvent.futuresAccountUpdate({
    required List<FuturesAssetBalance> assets,
    required List<FuturesPosition> positions,
  }) = FuturesAccountUpdate;
}
