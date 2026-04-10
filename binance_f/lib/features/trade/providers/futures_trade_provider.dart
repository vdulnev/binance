import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/models/app_exception.dart';
import '../../markets/data/models/symbol_filter.dart';
import '../../markets/data/models/symbol_info.dart';
import '../../markets/providers/exchange_info_provider.dart';
import '../data/filter_validator.dart';
import '../data/futures_trade_repository.dart';
import '../data/models/futures_order.dart';
import '../data/models/order_enums.dart';
import '../data/models/symbol_filters.dart';
import 'futures_open_orders_provider.dart';

/// Action-only provider for futures order placement with filter
/// validation (FR-5.3) and EC-9 reconciliation.
final futuresTradeProvider = NotifierProvider<FuturesTradeNotifier, void>(
  FuturesTradeNotifier.new,
);

class FuturesTradeNotifier extends Notifier<void> {
  late FuturesTradeRepository _repo;
  late Talker _talker;

  @override
  void build() {
    _repo = sl<FuturesTradeRepository>();
    _talker = sl<Talker>();
  }

  Future<FuturesOrder> placeOrder({
    required String symbol,
    required OrderSide side,
    required OrderType type,
    required Decimal quantity,
    Decimal? price,
    Decimal? stopPrice,
    Decimal? callbackRate,
    TimeInForce? timeInForce,
    bool reduceOnly = false,
    bool postOnly = false,
  }) async {
    // 1. Filter validation for limit-type orders.
    final filters = await _resolveFilters(symbol);
    if (filters != null && type.hasPrice && price != null) {
      final result = validateOrder(
        filters: filters,
        price: price,
        quantity: quantity,
      );
      result.match((err) => throw err, (_) {});
    }

    // 2. Generate clientOrderId for reconciliation.
    final clientOrderId = 'fapp_${DateTime.now().millisecondsSinceEpoch}';

    // 3. Submit.
    final result = await _repo
        .placeOrder(
          symbol: symbol,
          side: side,
          type: type,
          quantity: quantity,
          clientOrderId: clientOrderId,
          price: price,
          stopPrice: stopPrice,
          callbackRate: callbackRate,
          timeInForce: timeInForce,
          reduceOnly: reduceOnly,
          postOnly: postOnly,
        )
        .run();

    final order = await result.fold(
      (err) => _reconcileOrThrow(err, symbol, clientOrderId),
      (order) async => order,
    );

    // 4. Refresh open orders.
    ref.read(futuresOpenOrdersProvider.notifier).refresh();
    return order;
  }

  Future<FuturesOrder> _reconcileOrThrow(
    AppException err,
    String symbol,
    String clientOrderId,
  ) async {
    if (err is! NetworkException) throw err;

    _talker.warning(
      'FuturesTrade: place response lost for $clientOrderId, '
      'attempting reconciliation (EC-9)',
    );

    final queryResult = await _repo
        .queryOrder(symbol: symbol, clientOrderId: clientOrderId)
        .run();

    return queryResult.fold(
      (_) {
        _talker.error('FuturesTrade: reconciliation failed for $clientOrderId');
        throw err;
      },
      (order) {
        _talker.info(
          'FuturesTrade: reconciled order $clientOrderId → '
          '${order.status.name}',
        );
        return order;
      },
    );
  }

  Future<SymbolFilters?> _resolveFilters(String symbol) async {
    final infoAsync = ref.read(exchangeInfoProvider('futures'));
    final symbols = infoAsync.value;
    if (symbols == null) return null;

    final info = symbols.cast<SymbolInfo?>().firstWhere(
      (s) => s!.symbol == symbol,
      orElse: () => null,
    );
    if (info == null) return null;

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
      stepSize: ls?.stepSize ?? Decimal.parse('0.001'),
      minQty: ls?.minQty ?? Decimal.parse('0.001'),
      minNotional: mn?.minNotional ?? Decimal.parse('5'),
      maxQty: ls?.maxQty,
      minPrice: pf?.minPrice,
      maxPrice: pf?.maxPrice,
    );
  }
}
