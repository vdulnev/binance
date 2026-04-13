import 'package:binance_f/core/db/app_database.dart';
import 'package:binance_f/core/db/order_history_cache.dart';
import 'package:binance_f/features/trade/data/models/futures_order.dart';
import 'package:binance_f/features/trade/data/models/order_enums.dart';
import 'package:binance_f/features/trade/data/models/spot_order.dart';
import 'package:decimal/decimal.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late OrderHistoryCache cache;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    cache = OrderHistoryCache(database: db);
  });

  tearDown(() async {
    await db.close();
  });

  SpotOrder makeSpotOrder(int id, String symbol, int time) {
    return SpotOrder(
      symbol: symbol,
      orderId: id,
      clientOrderId: 'c$id',
      price: Decimal.parse('50000'),
      origQty: Decimal.parse('1'),
      executedQty: Decimal.zero,
      cummulativeQuoteQty: Decimal.zero,
      status: OrderStatus.NEW,
      timeInForce: TimeInForce.GTC,
      type: OrderType.LIMIT,
      side: OrderSide.BUY,
      time: time,
      updateTime: time,
    );
  }

  FuturesOrder makeFuturesOrder(int id, String symbol, int time) {
    return FuturesOrder(
      symbol: symbol,
      orderId: id,
      clientOrderId: 'cf$id',
      price: Decimal.parse('50000'),
      origQty: Decimal.parse('1'),
      executedQty: Decimal.zero,
      cumQuote: Decimal.zero,
      status: OrderStatus.NEW,
      timeInForce: TimeInForce.GTC,
      type: OrderType.LIMIT,
      side: OrderSide.BUY,
      time: time,
      updateTime: time,
      reduceOnly: false,
      closePosition: false,
      positionSide: 'BOTH',
      workingType: 'CONTRACT_PRICE',
    );
  }

  group('OrderHistoryCache', () {
    test('saveSpotOrders and loadSpotOrders works', () async {
      final orders = [
        makeSpotOrder(1, 'BTCUSDT', 1000),
        makeSpotOrder(2, 'ETHUSDT', 2000),
      ];

      await cache.saveSpotOrders(orders).run();

      final loaded = (await cache.loadSpotOrders().run()).getOrElse((_) => []);
      expect(loaded, hasLength(2));
      expect(loaded.any((o) => o.symbol == 'BTCUSDT'), isTrue);
      expect(loaded.any((o) => o.symbol == 'ETHUSDT'), isTrue);
    });

    test('loadSpotOrders filtering works', () async {
      final orders = [
        makeSpotOrder(1, 'BTCUSDT', 1000),
        makeSpotOrder(2, 'ETHUSDT', 2000),
        makeSpotOrder(3, 'BTCUSDT', 3000),
      ];

      await cache.saveSpotOrders(orders).run();

      // Filter by symbol
      final btcOnly = (await cache.loadSpotOrders(symbol: 'BTCUSDT').run())
          .getOrElse((_) => []);
      expect(btcOnly, hasLength(2));
      expect(btcOnly.every((o) => o.symbol == 'BTCUSDT'), isTrue);

      // Filter by time
      final timeFiltered = (await cache.loadSpotOrders(
        startTime: DateTime.fromMillisecondsSinceEpoch(1500),
        endTime: DateTime.fromMillisecondsSinceEpoch(2500),
      ).run()).getOrElse((_) => []);
      expect(timeFiltered, hasLength(1));
      expect(timeFiltered.first.orderId, 2);
    });

    test('saveFuturesOrders and loadFuturesOrders works', () async {
      final orders = [
        makeFuturesOrder(1, 'BTCUSDT', 1000),
      ];

      await cache.saveFuturesOrders(orders).run();

      final loaded = (await cache.loadFuturesOrders().run()).getOrElse((_) => []);
      expect(loaded, hasLength(1));
      expect(loaded.first.symbol, 'BTCUSDT');
    });

    test('cachedSymbols works', () async {
      await cache.saveSpotOrders([
        makeSpotOrder(1, 'BTCUSDT', 1000),
        makeSpotOrder(2, 'ETHUSDT', 2000),
      ]).run();
      
      await cache.saveFuturesOrders([
        makeFuturesOrder(3, 'SOLUSDT', 3000),
      ]).run();

      final spotSymbols = (await cache.cachedSymbols('spot').run())
          .getOrElse((_) => []);
      expect(spotSymbols, containsAll(['BTCUSDT', 'ETHUSDT']));
      expect(spotSymbols, isNot(contains('SOLUSDT')));

      final futuresSymbols = (await cache.cachedSymbols('futures').run())
          .getOrElse((_) => []);
      expect(futuresSymbols, contains('SOLUSDT'));
    });

    test('clear wipes everything', () async {
      await cache.saveSpotOrders([makeSpotOrder(1, 'BTCUSDT', 1000)]).run();
      await cache.saveFuturesOrders([makeFuturesOrder(2, 'ETHUSDT', 2000)]).run();

      await cache.clear().run();

      final spot = (await cache.loadSpotOrders().run()).getOrElse((_) => []);
      final futures = (await cache.loadFuturesOrders().run()).getOrElse((_) => []);
      
      expect(spot, isEmpty);
      expect(futures, isEmpty);
    });
  group('OrderHistoryCache sorting', () {
    test('loadSpotOrders returns orders in descending time order', () async {
      await cache.saveSpotOrders([
        makeSpotOrder(1, 'BTCUSDT', 1000),
        makeSpotOrder(2, 'BTCUSDT', 3000),
        makeSpotOrder(3, 'BTCUSDT', 2000),
      ]).run();

      final loaded = (await cache.loadSpotOrders().run()).getOrElse((_) => []);
      expect(loaded, hasLength(3));
      expect(loaded[0].time, 3000);
      expect(loaded[1].time, 2000);
      expect(loaded[2].time, 1000);
    });
  });
  });
}
