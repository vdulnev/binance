import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/alerts/data/alerts_repository.dart';
import 'package:binance_f/features/alerts/data/models/price_alert.dart';
import 'package:binance_f/features/alerts/providers/alerts_provider.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAlertsRepository extends Mock implements AlertsRepository {}

PriceAlert _makeAlert({int id = 1, String symbol = 'BTCUSDT'}) => PriceAlert(
  id: id,
  symbol: symbol,
  market: 'spot',
  direction: AlertDirection.above,
  targetPrice: Decimal.parse('50000'),
  createdAt: DateTime.now(),
);

void main() {
  late MockAlertsRepository mockRepo;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(AlertDirection.above);
    registerFallbackValue(Decimal.zero);
  });

  setUp(() {
    mockRepo = MockAlertsRepository();

    if (sl.isRegistered<AlertsRepository>()) {
      sl.unregister<AlertsRepository>();
    }
    sl.registerSingleton<AlertsRepository>(mockRepo);

    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
    sl.unregister<AlertsRepository>();
  });

  group('AlertsNotifier', () {
    test('build loads all alerts from repository', () async {
      final alerts = [_makeAlert(id: 1), _makeAlert(id: 2, symbol: 'ETHUSDT')];
      when(() => mockRepo.getAll()).thenReturn(TaskEither.right(alerts));

      // Read to trigger build
      final notifier = container.read(alertsProvider.notifier);
      await notifier.future;

      final state = container.read(alertsProvider);
      expect(state.value, hasLength(2));
    });

    test('build surfaces error from repository', () async {
      when(() => mockRepo.getAll()).thenReturn(
        TaskEither.left(const AppException.unknown(message: 'db error')),
      );

      // Listen for state changes — the provider will move from loading
      // to error when getAll returns Left.
      AsyncValue<List<PriceAlert>>? captured;
      container.listen(alertsProvider, (_, next) => captured = next);

      // Trigger build and wait for the microtask to settle.
      container.read(alertsProvider);
      await Future<void>.delayed(Duration.zero);

      expect(captured, isNotNull);
      expect(captured!.hasError, isTrue);
    });

    test('createAlert calls repo and invalidates', () async {
      when(() => mockRepo.getAll()).thenReturn(TaskEither.right([]));
      when(
        () => mockRepo.create(
          symbol: any(named: 'symbol'),
          market: any(named: 'market'),
          direction: any(named: 'direction'),
          targetPrice: any(named: 'targetPrice'),
        ),
      ).thenReturn(TaskEither.right(_makeAlert()));

      final notifier = container.read(alertsProvider.notifier);
      await notifier.future;

      // After create, getAll is called again due to invalidateSelf
      when(
        () => mockRepo.getAll(),
      ).thenReturn(TaskEither.right([_makeAlert()]));

      await notifier.createAlert(
        symbol: 'BTCUSDT',
        market: 'spot',
        direction: AlertDirection.above,
        targetPrice: Decimal.parse('50000'),
      );

      verify(
        () => mockRepo.create(
          symbol: 'BTCUSDT',
          market: 'spot',
          direction: AlertDirection.above,
          targetPrice: Decimal.parse('50000'),
        ),
      ).called(1);
    });

    test('deleteAlert calls repo and invalidates', () async {
      when(
        () => mockRepo.getAll(),
      ).thenReturn(TaskEither.right([_makeAlert()]));
      when(() => mockRepo.delete(any())).thenReturn(TaskEither.right(unit));

      final notifier = container.read(alertsProvider.notifier);
      await notifier.future;

      // After delete, getAll returns empty
      when(() => mockRepo.getAll()).thenReturn(TaskEither.right([]));

      await notifier.deleteAlert(1);

      verify(() => mockRepo.delete(1)).called(1);
    });

    test('toggleEnabled calls repo and invalidates', () async {
      when(
        () => mockRepo.getAll(),
      ).thenReturn(TaskEither.right([_makeAlert()]));
      when(
        () => mockRepo.setEnabled(any(), enabled: any(named: 'enabled')),
      ).thenReturn(TaskEither.right(unit));

      final notifier = container.read(alertsProvider.notifier);
      await notifier.future;

      when(() => mockRepo.getAll()).thenReturn(TaskEither.right([]));

      await notifier.toggleEnabled(1, enabled: false);

      verify(() => mockRepo.setEnabled(1, enabled: false)).called(1);
    });
  });
}
