import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/transfers/data/models/deposit.dart';
import 'package:binance_f/features/transfers/data/models/withdrawal.dart';
import 'package:binance_f/features/transfers/data/transfers_repository.dart';
import 'package:binance_f/features/transfers/providers/transfers_provider.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockTransfersRepository extends Mock implements TransfersRepository {}

Deposit _makeDeposit({String id = 'd1', String coin = 'BTC'}) => Deposit(
  id: id,
  amount: Decimal.parse('0.5'),
  coin: coin,
  network: coin,
  status: 1,
  address: 'addr',
  txId: 'tx',
  insertTime: 1700000000000,
);

Withdrawal _makeWithdrawal({String id = 'w1', String coin = 'ETH'}) =>
    Withdrawal(
      id: id,
      amount: Decimal.parse('1.0'),
      transactionFee: Decimal.parse('0.001'),
      coin: coin,
      network: coin,
      status: 6,
      address: 'addr',
      txId: 'tx',
      applyTime: '2024-01-15 10:30:00',
    );

void main() {
  late MockTransfersRepository mockRepo;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockTransfersRepository();

    if (sl.isRegistered<TransfersRepository>()) {
      sl.unregister<TransfersRepository>();
    }
    sl.registerSingleton<TransfersRepository>(mockRepo);

    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
    sl.unregister<TransfersRepository>();
  });

  group('DepositsNotifier', () {
    test('build loads deposits from repository', () async {
      final deposits = [_makeDeposit(), _makeDeposit(id: 'd2', coin: 'USDT')];
      when(
        () => mockRepo.getDeposits(
          coin: any(named: 'coin'),
          status: any(named: 'status'),
          startTime: any(named: 'startTime'),
          endTime: any(named: 'endTime'),
          limit: any(named: 'limit'),
        ),
      ).thenReturn(TaskEither.right(deposits));

      final notifier = container.read(depositsProvider.notifier);
      await notifier.future;

      final state = container.read(depositsProvider);
      expect(state.value, hasLength(2));
    });

    test('build surfaces error from repository', () async {
      when(
        () => mockRepo.getDeposits(
          coin: any(named: 'coin'),
          status: any(named: 'status'),
          startTime: any(named: 'startTime'),
          endTime: any(named: 'endTime'),
          limit: any(named: 'limit'),
        ),
      ).thenReturn(
        TaskEither.left(const AppException.unknown(message: 'api error')),
      );

      AsyncValue<List<Deposit>>? captured;
      container.listen(depositsProvider, (_, next) => captured = next);

      container.read(depositsProvider);
      await Future<void>.delayed(Duration.zero);

      expect(captured, isNotNull);
      expect(captured!.hasError, isTrue);
    });
  });

  group('WithdrawalsNotifier', () {
    test('build loads withdrawals from repository', () async {
      final withdrawals = [_makeWithdrawal()];
      when(
        () => mockRepo.getWithdrawals(
          coin: any(named: 'coin'),
          status: any(named: 'status'),
          startTime: any(named: 'startTime'),
          endTime: any(named: 'endTime'),
          limit: any(named: 'limit'),
        ),
      ).thenReturn(TaskEither.right(withdrawals));

      final notifier = container.read(withdrawalsProvider.notifier);
      await notifier.future;

      final state = container.read(withdrawalsProvider);
      expect(state.value, hasLength(1));
      expect(state.value!.first.coin, 'ETH');
    });
  });
}
