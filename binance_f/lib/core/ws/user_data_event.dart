import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/portfolio/data/models/futures_asset_balance.dart';
import '../../features/portfolio/data/models/futures_position.dart';
import '../../features/portfolio/data/models/spot_balance.dart';
import '../../features/trade/data/models/order_enums.dart';

part 'user_data_event.freezed.dart';

/// Events emitted by the user data stream.
///
/// Phase 3: portfolio-relevant events (account updates).
/// Phase 5: spot order execution reports.
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

  /// Spot `executionReport` — pushed on every order lifecycle event
  /// (NEW, PARTIALLY_FILLED, FILLED, CANCELED, REJECTED, EXPIRED).
  /// The open-orders provider uses this to keep its list in sync without
  /// REST polling.
  const factory UserDataEvent.spotOrderUpdate({
    required String symbol,
    required int orderId,
    required String clientOrderId,
    required OrderSide side,
    required OrderType orderType,
    required OrderStatus status,
    required Decimal price,
    required Decimal origQty,
    required Decimal executedQty,
    required Decimal cummulativeQuoteQty,
    TimeInForce? timeInForce,
    Decimal? stopPrice,
    required int time,
    required int updateTime,
  }) = SpotOrderUpdate;

  /// Futures `ORDER_TRADE_UPDATE` — pushed on every futures order
  /// lifecycle event. Analogous to spot's executionReport.
  const factory UserDataEvent.futuresOrderUpdate({
    required String symbol,
    required int orderId,
    required String clientOrderId,
    required OrderSide side,
    required OrderType orderType,
    required OrderStatus status,
    required Decimal price,
    required Decimal origQty,
    required Decimal executedQty,
    required Decimal cumQuote,
    TimeInForce? timeInForce,
    Decimal? stopPrice,
    Decimal? activatePrice,
    Decimal? callbackRate,
    required bool reduceOnly,
    required int time,
    required int updateTime,
  }) = FuturesOrderUpdate;
}
