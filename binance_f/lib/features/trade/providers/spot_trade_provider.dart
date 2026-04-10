import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/models/app_exception.dart';
import '../../markets/data/models/symbol_filter.dart';
import '../../markets/data/models/symbol_info.dart';
import '../../markets/providers/exchange_info_provider.dart';
import '../data/filter_validator.dart';
import '../data/models/oco_order_result.dart';
import '../data/models/order_enums.dart';
import '../data/models/spot_order.dart';
import '../data/models/symbol_filters.dart';
import '../data/spot_trade_repository.dart';
import 'open_orders_provider.dart';

/// Provider that exposes order-placement actions with built-in filter
/// validation (FR-5.3) and EC-9 reconciliation on lost responses.
///
/// This is NOT an AsyncNotifier because it doesn't own persistent state —
/// it's an action-only provider. The open-orders list lives in
/// [openOrdersProvider].
final spotTradeProvider = NotifierProvider<SpotTradeNotifier, void>(
  SpotTradeNotifier.new,
);

class SpotTradeNotifier extends Notifier<void> {
  late SpotTradeRepository _repo;
  late Talker _talker;

  @override
  void build() {
    _repo = sl<SpotTradeRepository>();
    _talker = sl<Talker>();
  }

  /// Place a spot order. Steps:
  /// 1. Resolve symbol filters from exchangeInfo cache.
  /// 2. Client-side filter validation (FR-5.3).
  /// 3. Submit to Binance.
  /// 4. On network failure → EC-9 reconciliation via queryOrder.
  /// 5. Refresh open orders.
  Future<SpotOrder> placeOrder({
    required String symbol,
    required OrderSide side,
    required OrderType type,
    required Decimal quantity,
    Decimal? price,
    Decimal? stopPrice,
    TimeInForce? timeInForce,
  }) async {
    // 1. Resolve filters.
    final filters = await _resolveFilters(symbol);

    // 2. Client-side validation. Market orders skip price validation.
    if (filters != null && type != OrderType.MARKET) {
      final validationPrice = price ?? Decimal.zero;
      final result = validateOrder(
        filters: filters,
        price: validationPrice,
        quantity: quantity,
      );
      result.match((err) => throw err, (_) {});
    }

    // 3. Generate clientOrderId for reconciliation.
    final clientOrderId = 'app_${DateTime.now().millisecondsSinceEpoch}';

    // 4. Submit.
    final result = await _repo
        .placeOrder(
          symbol: symbol,
          side: side,
          type: type,
          quantity: quantity,
          clientOrderId: clientOrderId,
          price: price,
          stopPrice: stopPrice,
          timeInForce: timeInForce,
        )
        .run();

    final order = await result.fold(
      (err) => _reconcileOrThrow(err, symbol, clientOrderId),
      (order) async => order,
    );

    // 5. Refresh open orders.
    ref.read(openOrdersProvider.notifier).refresh();
    return order;
  }

  /// Place an OCO order pair.
  Future<OcoOrderResult> placeOco({
    required String symbol,
    required OrderSide side,
    required Decimal quantity,
    required Decimal price,
    required Decimal stopPrice,
    required Decimal stopLimitPrice,
    TimeInForce stopLimitTimeInForce = TimeInForce.GTC,
  }) async {
    final clientOrderId = 'app_oco_${DateTime.now().millisecondsSinceEpoch}';

    final result = await _repo
        .placeOco(
          symbol: symbol,
          side: side,
          quantity: quantity,
          price: price,
          stopPrice: stopPrice,
          stopLimitPrice: stopLimitPrice,
          listClientOrderId: clientOrderId,
          stopLimitTimeInForce: stopLimitTimeInForce,
        )
        .run();

    final oco = result.fold((err) => throw err, (oco) => oco);

    ref.read(openOrdersProvider.notifier).refresh();
    return oco;
  }

  /// EC-9: If the place response was lost due to a network error,
  /// try to find the order by clientOrderId before giving up.
  Future<SpotOrder> _reconcileOrThrow(
    AppException err,
    String symbol,
    String clientOrderId,
  ) async {
    if (err is! NetworkException) throw err;

    _talker.warning(
      'SpotTrade: place response lost for $clientOrderId, '
      'attempting reconciliation (EC-9)',
    );

    final queryResult = await _repo
        .queryOrder(symbol: symbol, clientOrderId: clientOrderId)
        .run();

    return queryResult.fold(
      (_) {
        _talker.error('SpotTrade: reconciliation failed for $clientOrderId');
        throw err;
      },
      (order) {
        _talker.info(
          'SpotTrade: reconciled order $clientOrderId → '
          '${order.status.name}',
        );
        return order;
      },
    );
  }

  /// Resolve [SymbolFilters] from the exchangeInfo provider cache.
  Future<SymbolFilters?> _resolveFilters(String symbol) async {
    final infoAsync = ref.read(exchangeInfoProvider('spot'));
    final symbols = infoAsync.value;
    if (symbols == null) return null;

    final info = symbols.cast<SymbolInfo?>().firstWhere(
      (s) => s!.symbol == symbol,
      orElse: () => null,
    );
    if (info == null) return null;

    return _extractFilters(info);
  }

  SymbolFilters _extractFilters(SymbolInfo info) {
    PriceFilter? pf;
    LotSize? ls;
    MinNotional? mn;

    for (final f in info.filters) {
      switch (f) {
        case PriceFilter():
          pf = f;
        case LotSize():
          ls = f;
        case MinNotional():
          mn = f;
        case SymbolFilterOther():
          break;
      }
    }

    return SymbolFilters(
      symbol: info.symbol,
      tickSize: pf?.tickSize ?? Decimal.parse('0.01'),
      stepSize: ls?.stepSize ?? Decimal.parse('0.00001'),
      minQty: ls?.minQty ?? Decimal.parse('0.00001'),
      minNotional: mn?.minNotional ?? Decimal.parse('10'),
      maxQty: ls?.maxQty,
      minPrice: pf?.minPrice,
      maxPrice: pf?.maxPrice,
    );
  }
}
