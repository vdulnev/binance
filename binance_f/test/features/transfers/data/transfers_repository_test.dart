import 'package:binance_f/core/auth/session_manager.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/transfers/data/models/deposit.dart';
import 'package:binance_f/features/transfers/data/models/withdrawal.dart';
import 'package:binance_f/features/transfers/data/transfers_repository.dart';
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockSessionManager extends Mock implements SessionManager {}

void main() {
  late MockDio mockDio;
  late MockSessionManager mockSession;
  late BinanceTransfersRepository repo;

  setUpAll(() {
    registerFallbackValue(CancelToken());
  });

  setUp(() {
    mockDio = MockDio();
    mockSession = MockSessionManager();
    repo = BinanceTransfersRepository(
      spotDio: () => mockDio,
      sessionManager: mockSession,
    );
  });

  group('getDeposits', () {
    test('parses deposit list from response', () async {
      when(
        () => mockDio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response<List<dynamic>>(
          data: [
            {
              'id': 'dep1',
              'amount': '0.5',
              'coin': 'BTC',
              'network': 'BTC',
              'status': 1,
              'address': 'bc1q...',
              'txId': 'abc123',
              'insertTime': 1700000000000,
            },
            {
              'id': 'dep2',
              'amount': '100',
              'coin': 'USDT',
              'network': 'TRX',
              'status': 0,
              'address': 'T...',
              'txId': 'def456',
              'insertTime': 1700001000000,
            },
          ],
          requestOptions: RequestOptions(
            path: '/sapi/v1/capital/deposit/hisrec',
          ),
          statusCode: 200,
        ),
      );

      final result = await repo.getDeposits().run();
      final deposits = result.getOrElse(
        (_) => throw StateError('expected Right'),
      );

      expect(deposits, hasLength(2));
      // Should be sorted newest-first
      expect(deposits.first.id, 'dep2');
      expect(deposits.first.coin, 'USDT');
      expect(deposits.first.amount, Decimal.parse('100'));
      expect(deposits.last.id, 'dep1');
    });

    test('returns empty list when API returns empty', () async {
      when(
        () => mockDio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response<List<dynamic>>(
          data: [],
          requestOptions: RequestOptions(
            path: '/sapi/v1/capital/deposit/hisrec',
          ),
          statusCode: 200,
        ),
      );

      final result = await repo.getDeposits().run();
      final deposits = result.getOrElse(
        (_) => throw StateError('expected Right'),
      );
      expect(deposits, isEmpty);
    });

    test('returns AppException on Dio error', () async {
      when(
        () => mockDio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/'),
          error: const AppException.network(message: 'timeout'),
        ),
      );

      final result = await repo.getDeposits().run();
      expect(result.isLeft(), isTrue);
    });
  });

  group('getWithdrawals', () {
    test('parses withdrawal list from response', () async {
      when(
        () => mockDio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response<List<dynamic>>(
          data: [
            {
              'id': 'w1',
              'amount': '1.5',
              'transactionFee': '0.0005',
              'coin': 'ETH',
              'network': 'ETH',
              'status': 6,
              'address': '0x...',
              'txId': 'tx1',
              'applyTime': '2024-01-15 10:30:00',
            },
          ],
          requestOptions: RequestOptions(
            path: '/sapi/v1/capital/withdraw/history',
          ),
          statusCode: 200,
        ),
      );

      final result = await repo.getWithdrawals().run();
      final withdrawals = result.getOrElse(
        (_) => throw StateError('expected Right'),
      );

      expect(withdrawals, hasLength(1));
      expect(withdrawals.first.coin, 'ETH');
      expect(withdrawals.first.amount, Decimal.parse('1.5'));
      expect(withdrawals.first.transactionFee, Decimal.parse('0.0005'));
      expect(withdrawals.first.statusLabel, 'Completed');
    });
  });

  group('getDepositAddress', () {
    test('parses deposit address from response', () async {
      when(
        () => mockDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: {
            'coin': 'BTC',
            'address': 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
            'tag': '',
            'url': 'https://btc.com/bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
          },
          requestOptions: RequestOptions(
            path: '/sapi/v1/capital/deposit/address',
          ),
          statusCode: 200,
        ),
      );

      final result = await repo.getDepositAddress(coin: 'BTC').run();
      final addr = result.getOrElse((_) => throw StateError('expected Right'));

      expect(addr.coin, 'BTC');
      expect(addr.address, startsWith('bc1q'));
      expect(addr.tag, isEmpty);
    });
  });

  group('model status labels', () {
    test('Deposit.statusLabel maps all known statuses', () {
      Deposit makeDeposit(int status) => Deposit(
        id: 'x',
        amount: Decimal.one,
        coin: 'BTC',
        network: 'BTC',
        status: status,
        address: 'addr',
        txId: 'tx',
        insertTime: 0,
      );

      expect(makeDeposit(0).statusLabel, 'Pending');
      expect(makeDeposit(6).statusLabel, 'Credited');
      expect(makeDeposit(1).statusLabel, 'Success');
      expect(makeDeposit(99).statusLabel, 'Unknown (99)');
    });

    test('Withdrawal.statusLabel maps all known statuses', () {
      Withdrawal makeWithdrawal(int status) => Withdrawal(
        id: 'x',
        amount: Decimal.one,
        transactionFee: Decimal.zero,
        coin: 'ETH',
        network: 'ETH',
        status: status,
        address: 'addr',
        txId: 'tx',
        applyTime: '2024-01-01 00:00:00',
      );

      expect(makeWithdrawal(0).statusLabel, 'Email Sent');
      expect(makeWithdrawal(1).statusLabel, 'Cancelled');
      expect(makeWithdrawal(2).statusLabel, 'Awaiting Approval');
      expect(makeWithdrawal(3).statusLabel, 'Rejected');
      expect(makeWithdrawal(4).statusLabel, 'Processing');
      expect(makeWithdrawal(5).statusLabel, 'Failure');
      expect(makeWithdrawal(6).statusLabel, 'Completed');
      expect(makeWithdrawal(99).statusLabel, 'Unknown (99)');
    });
  });
}
