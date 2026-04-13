import 'package:binance_f/core/db/app_database.dart';
import 'package:binance_f/features/alerts/data/alerts_repository.dart';
import 'package:binance_f/features/alerts/data/models/price_alert.dart';
import 'package:decimal/decimal.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftAlertsRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = DriftAlertsRepository(database: db);
  });

  tearDown(() async {
    await db.close();
  });

  group('DriftAlertsRepository', () {
    test('create inserts and returns alert with auto-generated id', () async {
      final result = await repo
          .create(
            symbol: 'BTCUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('50000'),
          )
          .run();

      final alert = result.getOrElse((_) => throw StateError('expected Right'));
      expect(alert.id, greaterThan(0));
      expect(alert.symbol, 'BTCUSDT');
      expect(alert.market, 'spot');
      expect(alert.direction, AlertDirection.above);
      expect(alert.targetPrice, Decimal.parse('50000'));
      expect(alert.enabled, isTrue);
      expect(alert.triggeredAt, isNull);
    });

    test('getAll returns all created alerts', () async {
      await repo
          .create(
            symbol: 'BTCUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('50000'),
          )
          .run();
      await repo
          .create(
            symbol: 'ETHUSDT',
            market: 'spot',
            direction: AlertDirection.below,
            targetPrice: Decimal.parse('3000'),
          )
          .run();

      final result = await repo.getAll().run();
      final alerts = result.getOrElse(
        (_) => throw StateError('expected Right'),
      );

      expect(alerts, hasLength(2));
      final symbols = alerts.map((a) => a.symbol).toSet();
      expect(symbols, containsAll(['BTCUSDT', 'ETHUSDT']));
    });

    test('getEnabled excludes disabled and triggered alerts', () async {
      // Create 3 alerts
      final r1 = await repo
          .create(
            symbol: 'BTCUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('50000'),
          )
          .run();
      final a1 = r1.getOrElse((_) => throw StateError('expected Right'));

      final r2 = await repo
          .create(
            symbol: 'ETHUSDT',
            market: 'spot',
            direction: AlertDirection.below,
            targetPrice: Decimal.parse('3000'),
          )
          .run();
      final a2 = r2.getOrElse((_) => throw StateError('expected Right'));

      await repo
          .create(
            symbol: 'BNBUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('600'),
          )
          .run();

      // Disable first alert
      await repo.setEnabled(a1.id, enabled: false).run();
      // Trigger second alert
      await repo.markTriggered(a2.id, DateTime.now()).run();

      final result = await repo.getEnabled().run();
      final enabled = result.getOrElse(
        (_) => throw StateError('expected Right'),
      );

      expect(enabled, hasLength(1));
      expect(enabled.first.symbol, 'BNBUSDT');
    });

    test('delete removes alert by id', () async {
      final r = await repo
          .create(
            symbol: 'BTCUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('50000'),
          )
          .run();
      final alert = r.getOrElse((_) => throw StateError('expected Right'));

      await repo.delete(alert.id).run();

      final result = await repo.getAll().run();
      final all = result.getOrElse((_) => throw StateError('expected Right'));
      expect(all, isEmpty);
    });

    test('setEnabled toggles the enabled flag', () async {
      final r = await repo
          .create(
            symbol: 'BTCUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('50000'),
          )
          .run();
      final alert = r.getOrElse((_) => throw StateError('expected Right'));

      await repo.setEnabled(alert.id, enabled: false).run();

      final result = await repo.getAll().run();
      final alerts = result.getOrElse(
        (_) => throw StateError('expected Right'),
      );
      expect(alerts.first.enabled, isFalse);
    });

    test('markTriggered sets triggeredAt and disables', () async {
      final r = await repo
          .create(
            symbol: 'BTCUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('50000'),
          )
          .run();
      final alert = r.getOrElse((_) => throw StateError('expected Right'));

      final now = DateTime.now();
      await repo.markTriggered(alert.id, now).run();

      final result = await repo.getAll().run();
      final alerts = result.getOrElse(
        (_) => throw StateError('expected Right'),
      );
      expect(alerts.first.triggeredAt, isNotNull);
      expect(alerts.first.enabled, isFalse);
    });

    test('clearAll wipes all alerts', () async {
      await repo
          .create(
            symbol: 'BTCUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('50000'),
          )
          .run();
      await repo
          .create(
            symbol: 'ETHUSDT',
            market: 'spot',
            direction: AlertDirection.below,
            targetPrice: Decimal.parse('3000'),
          )
          .run();

      await repo.clearAll().run();

      final result = await repo.getAll().run();
      final all = result.getOrElse((_) => throw StateError('expected Right'));
      expect(all, isEmpty);
    });

    test('watchEnabled emits updated list on changes', () async {
      final stream = repo.watchEnabled();

      // First emission should be empty
      expectLater(
        stream,
        emitsInOrder([
          isEmpty, // initial
          hasLength(1), // after create
          isEmpty, // after disable
        ]),
      );

      // Allow the watch query to set up
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final r = await repo
          .create(
            symbol: 'BTCUSDT',
            market: 'spot',
            direction: AlertDirection.above,
            targetPrice: Decimal.parse('50000'),
          )
          .run();
      final alert = r.getOrElse((_) => throw StateError('expected Right'));

      await Future<void>.delayed(const Duration(milliseconds: 50));

      await repo.setEnabled(alert.id, enabled: false).run();

      await Future<void>.delayed(const Duration(milliseconds: 50));
    });
  });
}
