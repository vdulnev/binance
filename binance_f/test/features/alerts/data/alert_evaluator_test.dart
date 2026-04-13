import 'dart:async';

import 'package:binance_f/features/alerts/data/alert_evaluator.dart';
import 'package:binance_f/features/alerts/data/alerts_repository.dart';
import 'package:binance_f/features/alerts/data/models/price_alert.dart';
import 'package:binance_f/features/markets/data/market_ws_manager.dart';
import 'package:binance_f/features/markets/data/models/ticker_24h.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker/talker.dart';

class MockAlertsRepository extends Mock implements AlertsRepository {}

class MockMarketWsManager extends Mock implements MarketWsManager {}

Ticker24h _ticker(String symbol, String price) => Ticker24h(
  symbol: symbol,
  lastPrice: Decimal.parse(price),
  priceChange: Decimal.zero,
  priceChangePercent: Decimal.zero,
  volume: Decimal.zero,
  quoteVolume: Decimal.zero,
  highPrice: Decimal.zero,
  lowPrice: Decimal.zero,
);

PriceAlert _alert({
  int id = 1,
  String symbol = 'BTCUSDT',
  AlertDirection direction = AlertDirection.above,
  String targetPrice = '50000',
}) => PriceAlert(
  id: id,
  symbol: symbol,
  market: 'spot',
  direction: direction,
  targetPrice: Decimal.parse(targetPrice),
  createdAt: DateTime.now(),
);

void main() {
  late MockAlertsRepository mockRepo;
  late MockMarketWsManager mockWs;
  late StreamController<List<PriceAlert>> alertsController;
  late StreamController<Ticker24h> tickerController;
  late List<(PriceAlert, Decimal)> triggeredAlerts;
  late AlertEvaluator evaluator;

  setUp(() {
    mockRepo = MockAlertsRepository();
    mockWs = MockMarketWsManager();
    alertsController = StreamController<List<PriceAlert>>.broadcast();
    tickerController = StreamController<Ticker24h>.broadcast();
    triggeredAlerts = [];

    when(
      () => mockRepo.watchEnabled(),
    ).thenAnswer((_) => alertsController.stream);
    when(() => mockWs.tickerStream).thenAnswer(
      (_) => tickerController.stream,
    );
    when(
      () => mockWs.subscribe(any(), any(), market: any(named: 'market')),
    ).thenAnswer((_) async {});
    when(
      () => mockRepo.markTriggered(any(), any()),
    ).thenReturn(TaskEither.right(unit));

    evaluator = AlertEvaluator(
      alertsRepository: mockRepo,
      marketWsManager: mockWs,
      talker: Talker(),
      onTriggered: (alert, price) => triggeredAlerts.add((alert, price)),
    );
  });

  tearDown(() async {
    evaluator.dispose();
    await alertsController.close();
    await tickerController.close();
  });

  group('AlertEvaluator', () {
    test('fires alert when price crosses above threshold', () async {
      evaluator.start();

      final alert = _alert(direction: AlertDirection.above);
      alertsController.add([alert]);
      await Future<void>.delayed(Duration.zero);

      // First tick: establish baseline at 49000 (below threshold)
      tickerController.add(_ticker('BTCUSDT', '49000'));
      await Future<void>.delayed(Duration.zero);
      expect(triggeredAlerts, isEmpty);

      // Second tick: crosses above 50000
      tickerController.add(_ticker('BTCUSDT', '51000'));
      await Future<void>.delayed(Duration.zero);

      expect(triggeredAlerts, hasLength(1));
      expect(triggeredAlerts.first.$1.id, alert.id);
      expect(triggeredAlerts.first.$2, Decimal.parse('51000'));

      verify(() => mockRepo.markTriggered(alert.id, any())).called(1);
    });

    test('fires alert when price crosses below threshold', () async {
      evaluator.start();

      final alert = _alert(
        direction: AlertDirection.below,
        targetPrice: '50000',
      );
      alertsController.add([alert]);
      await Future<void>.delayed(Duration.zero);

      tickerController.add(_ticker('BTCUSDT', '51000'));
      await Future<void>.delayed(Duration.zero);
      expect(triggeredAlerts, isEmpty);

      tickerController.add(_ticker('BTCUSDT', '49000'));
      await Future<void>.delayed(Duration.zero);

      expect(triggeredAlerts, hasLength(1));
      expect(triggeredAlerts.first.$1.direction, AlertDirection.below);
    });

    test(
      'does NOT fire when price stays above threshold (no crossing)',
      () async {
        evaluator.start();

        final alert = _alert(direction: AlertDirection.above);
        alertsController.add([alert]);
        await Future<void>.delayed(Duration.zero);

        tickerController.add(_ticker('BTCUSDT', '51000'));
        await Future<void>.delayed(Duration.zero);
        tickerController.add(_ticker('BTCUSDT', '52000'));
        await Future<void>.delayed(Duration.zero);

        expect(triggeredAlerts, isEmpty);
      },
    );

    test(
      'does NOT fire when price stays below threshold (no crossing)',
      () async {
        evaluator.start();

        final alert = _alert(direction: AlertDirection.below);
        alertsController.add([alert]);
        await Future<void>.delayed(Duration.zero);

        tickerController.add(_ticker('BTCUSDT', '48000'));
        await Future<void>.delayed(Duration.zero);
        tickerController.add(_ticker('BTCUSDT', '49000'));
        await Future<void>.delayed(Duration.zero);

        expect(triggeredAlerts, isEmpty);
      },
    );

    test('does NOT fire on first tick (no previous price)', () async {
      evaluator.start();

      final alert = _alert(direction: AlertDirection.above);
      alertsController.add([alert]);
      await Future<void>.delayed(Duration.zero);

      // First tick above threshold — should NOT fire because we need
      // two data points to detect a crossing.
      tickerController.add(_ticker('BTCUSDT', '55000'));
      await Future<void>.delayed(Duration.zero);

      expect(triggeredAlerts, isEmpty);
    });

    test('multiple alerts on same symbol fire independently', () async {
      evaluator.start();

      final alertAbove = _alert(
        id: 1,
        direction: AlertDirection.above,
        targetPrice: '50000',
      );
      final alertBelow = _alert(
        id: 2,
        direction: AlertDirection.below,
        targetPrice: '48000',
      );
      alertsController.add([alertAbove, alertBelow]);
      await Future<void>.delayed(Duration.zero);

      // Baseline at 49000 (between both thresholds)
      tickerController.add(_ticker('BTCUSDT', '49000'));
      await Future<void>.delayed(Duration.zero);

      // Cross above 50000 — only alertAbove fires
      tickerController.add(_ticker('BTCUSDT', '51000'));
      await Future<void>.delayed(Duration.zero);

      expect(triggeredAlerts, hasLength(1));
      expect(triggeredAlerts.first.$1.id, 1);
    });

    test('stop cancels subscriptions and clears state', () async {
      evaluator.start();
      expect(evaluator.isRunning, isTrue);

      final alert = _alert(direction: AlertDirection.above);
      alertsController.add([alert]);
      await Future<void>.delayed(Duration.zero);

      evaluator.stop();
      expect(evaluator.isRunning, isFalse);

      // Ticks after stop should be ignored
      tickerController.add(_ticker('BTCUSDT', '49000'));
      await Future<void>.delayed(Duration.zero);
      tickerController.add(_ticker('BTCUSDT', '51000'));
      await Future<void>.delayed(Duration.zero);

      expect(triggeredAlerts, isEmpty);
    });

    test('reconciles WS subscriptions for new alert symbols', () async {
      evaluator.start();

      alertsController.add([_alert(symbol: 'BTCUSDT')]);
      await Future<void>.delayed(Duration.zero);

      verify(
        () => mockWs.subscribe('BTCUSDT', const {
          StreamType.ticker,
        }, market: 'spot'),
      ).called(1);

      // Adding a second alert for the same symbol should not subscribe again
      alertsController.add([
        _alert(id: 1, symbol: 'BTCUSDT'),
        _alert(id: 2, symbol: 'ETHUSDT'),
      ]);
      await Future<void>.delayed(Duration.zero);

      verify(
        () => mockWs.subscribe('ETHUSDT', const {
          StreamType.ticker,
        }, market: 'spot'),
      ).called(1);
      // BTCUSDT was NOT called again
      verifyNever(
        () => mockWs.subscribe('BTCUSDT', const {
          StreamType.ticker,
        }, market: 'spot'),
      );
    });

    test('start is idempotent', () {
      evaluator.start();
      evaluator.start(); // second call is no-op

      expect(evaluator.isRunning, isTrue);
    });

    test('ignores tickers for symbols without active alerts', () async {
      evaluator.start();

      alertsController.add([_alert(symbol: 'BTCUSDT')]);
      await Future<void>.delayed(Duration.zero);

      tickerController.add(_ticker('ETHUSDT', '3000'));
      await Future<void>.delayed(Duration.zero);
      tickerController.add(_ticker('ETHUSDT', '4000'));
      await Future<void>.delayed(Duration.zero);

      expect(triggeredAlerts, isEmpty);
    });
  });
}
