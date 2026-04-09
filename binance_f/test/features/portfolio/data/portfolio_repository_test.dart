import 'package:binance_f/core/auth/session_manager.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/portfolio/data/portfolio_repository.dart';
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockSessionManager extends Mock implements SessionManager {}

class _FakeRequestOptions extends Fake implements RequestOptions {}

class _FakeCancelToken extends Fake implements CancelToken {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeRequestOptions());
    registerFallbackValue(_FakeCancelToken());
  });

  late MockDio spotDio;
  late MockDio futuresDio;
  late MockSessionManager session;
  late BinancePortfolioRepository repo;

  setUp(() {
    spotDio = MockDio();
    futuresDio = MockDio();
    session = MockSessionManager();
    repo = BinancePortfolioRepository(
      spotDio: () => spotDio,
      futuresDio: () => futuresDio,
      sessionManager: session,
    );

    when(() => session.registerCancelToken(any())).thenReturn(null);
    when(() => session.unregisterCancelToken(any())).thenReturn(null);
  });

  group('getSpotAccount', () {
    test(
      'sends omitZeroBalances=true to /api/v3/account and parses balances',
      () async {
        when(
          () => spotDio.get<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/api/v3/account'),
            statusCode: 200,
            data: <String, dynamic>{
              'balances': <Map<String, dynamic>>[
                {'asset': 'BTC', 'free': '1.5', 'locked': '0.5'},
                {'asset': 'USDT', 'free': '100.0', 'locked': '0'},
                // Should be filtered out even if omitZeroBalances is honored.
                {'asset': 'DUST', 'free': '0', 'locked': '0'},
              ],
              'commissionRates': <String, dynamic>{
                'maker': '0.001',
                'taker': '0.001',
              },
            },
          ),
        );

        final result = await repo.getSpotAccount().run();

        expect(result.isRight(), isTrue);
        final snapshot = result.getOrElse((_) => throw StateError('left'));
        expect(snapshot.balances, hasLength(2));
        expect(snapshot.balances[0].asset, 'BTC');
        expect(snapshot.balances[0].free, Decimal.parse('1.5'));
        expect(snapshot.balances[0].locked, Decimal.parse('0.5'));
        expect(snapshot.balances[1].asset, 'USDT');
        expect(snapshot.commissionRates?['maker'], '0.001');

        final captured = verify(
          () => spotDio.get<Map<String, dynamic>>(
            captureAny(),
            queryParameters: captureAny(named: 'queryParameters'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).captured;
        expect(captured[0], '/api/v3/account');
        expect((captured[1] as Map)['omitZeroBalances'], 'true');
      },
    );

    test('registers a CancelToken and unregisters it after success', () async {
      when(
        () => spotDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/api/v3/account'),
          statusCode: 200,
          data: <String, dynamic>{'balances': <Map<String, dynamic>>[]},
        ),
      );

      await repo.getSpotAccount().run();

      verify(() => session.registerCancelToken(any())).called(1);
      verify(() => session.unregisterCancelToken(any())).called(1);
    });

    test('DioException carrying AppException is unwrapped into Left', () async {
      when(
        () => spotDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/v3/account'),
          error: const AppException.auth(message: 'bad key'),
        ),
      );

      final result = await repo.getSpotAccount().run();

      expect(result.isLeft(), isTrue);
      result.match(
        (err) => expect(err, isA<AuthException>()),
        (_) => fail('expected Left'),
      );
      // Even on failure the token is released.
      verify(() => session.unregisterCancelToken(any())).called(1);
    });
  });

  group('getFuturesAccount', () {
    test('parses assets, positions, and totals', () async {
      when(
        () => futuresDio.get<Map<String, dynamic>>(
          any(),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: '/fapi/v2/account'),
          statusCode: 200,
          data: <String, dynamic>{
            'totalWalletBalance': '1000.5',
            'totalUnrealizedProfit': '-12.5',
            'totalMarginBalance': '988.0',
            'assets': <Map<String, dynamic>>[
              {
                'asset': 'USDT',
                'walletBalance': '1000.5',
                'unrealizedProfit': '-12.5',
                'marginBalance': '988.0',
                'availableBalance': '900.0',
              },
              {
                'asset': 'DUST',
                'walletBalance': '0',
                'unrealizedProfit': '0',
                'marginBalance': '0',
                'availableBalance': '0',
              },
            ],
            'positions': <Map<String, dynamic>>[
              {
                'symbol': 'BTCUSDT',
                'positionAmt': '0.5',
                'entryPrice': '29000',
                'unrealizedProfit': '500',
                'liquidationPrice': '25000',
                'leverage': '10',
                'marginType': 'cross',
              },
              {
                'symbol': 'ETHUSDT',
                'positionAmt': '0',
                'entryPrice': '0',
                'unrealizedProfit': '0',
                'leverage': '1',
                'marginType': 'cross',
              },
            ],
          },
        ),
      );

      final result = await repo.getFuturesAccount().run();

      expect(result.isRight(), isTrue);
      final snapshot = result.getOrElse((_) => throw StateError('left'));
      expect(snapshot.totalWalletBalance, Decimal.parse('1000.5'));
      expect(snapshot.assets, hasLength(1));
      expect(snapshot.assets.first.asset, 'USDT');
      expect(snapshot.positions, hasLength(1));
      expect(snapshot.positions.first.symbol, 'BTCUSDT');
      expect(snapshot.positions.first.leverage, Decimal.parse('10'));

      // Correct endpoint path was used.
      final captured = verify(
        () => futuresDio.get<Map<String, dynamic>>(
          captureAny(),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).captured;
      expect(captured[0], '/fapi/v2/account');
    });
  });

  group('getAllPrices', () {
    test('parses ticker list into a map<symbol, Decimal>', () async {
      when(
        () => spotDio.get<List<dynamic>>(
          any(),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response<List<dynamic>>(
          requestOptions: RequestOptions(path: '/api/v3/ticker/price'),
          statusCode: 200,
          data: [
            {'symbol': 'BTCUSDT', 'price': '30000.25'},
            {'symbol': 'ETHUSDT', 'price': '2000.10'},
          ],
        ),
      );

      final result = await repo.getAllPrices().run();

      expect(result.isRight(), isTrue);
      final map = result.getOrElse((_) => throw StateError('left'));
      expect(map['BTCUSDT'], Decimal.parse('30000.25'));
      expect(map['ETHUSDT'], Decimal.parse('2000.10'));

      final captured = verify(
        () => spotDio.get<List<dynamic>>(
          captureAny(),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).captured;
      expect(captured[0], '/api/v3/ticker/price');
    });

    test('network failure surfaces as Left(NetworkException)', () async {
      when(
        () => spotDio.get<List<dynamic>>(
          any(),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/v3/ticker/price'),
          error: const AppException.network(message: 'offline'),
        ),
      );

      final result = await repo.getAllPrices().run();

      expect(result.isLeft(), isTrue);
      result.match(
        (err) => expect(err, isA<NetworkException>()),
        (_) => fail('expected Left'),
      );
    });
  });
}
