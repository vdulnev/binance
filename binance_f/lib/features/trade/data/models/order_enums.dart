// Enums used across spot (Phase 5) and futures (Phase 6) order models.
// Values match the Binance API string representations exactly so
// `.name` can be sent directly in query parameters.

// ignore_for_file: constant_identifier_names

enum OrderSide { BUY, SELL }

enum OrderType {
  MARKET,
  LIMIT,
  STOP_LOSS,
  STOP_LOSS_LIMIT,
  TAKE_PROFIT,
  TAKE_PROFIT_LIMIT,
  LIMIT_MAKER,
}

enum TimeInForce { GTC, IOC, FOK }

enum OrderStatus {
  NEW,
  PARTIALLY_FILLED,
  FILLED,
  CANCELED,
  PENDING_CANCEL,
  REJECTED,
  EXPIRED,
  EXPIRED_IN_MATCH,
}

/// Human-readable label for order types shown in the UI.
extension OrderTypeLabel on OrderType {
  String get label => switch (this) {
    OrderType.MARKET => 'Market',
    OrderType.LIMIT => 'Limit',
    OrderType.STOP_LOSS => 'Stop Loss',
    OrderType.STOP_LOSS_LIMIT => 'Stop Limit',
    OrderType.TAKE_PROFIT => 'Take Profit',
    OrderType.TAKE_PROFIT_LIMIT => 'Take Profit Limit',
    OrderType.LIMIT_MAKER => 'Limit Maker',
  };

  /// Whether this order type requires a price field.
  bool get hasPrice => switch (this) {
    OrderType.LIMIT ||
    OrderType.STOP_LOSS_LIMIT ||
    OrderType.TAKE_PROFIT_LIMIT ||
    OrderType.LIMIT_MAKER => true,
    _ => false,
  };

  /// Whether this order type requires a stop price field.
  bool get hasStopPrice => switch (this) {
    OrderType.STOP_LOSS ||
    OrderType.STOP_LOSS_LIMIT ||
    OrderType.TAKE_PROFIT ||
    OrderType.TAKE_PROFIT_LIMIT => true,
    _ => false,
  };

  /// Whether this order type requires a timeInForce field.
  bool get hasTimeInForce => switch (this) {
    OrderType.LIMIT ||
    OrderType.STOP_LOSS_LIMIT ||
    OrderType.TAKE_PROFIT_LIMIT => true,
    _ => false,
  };
}
