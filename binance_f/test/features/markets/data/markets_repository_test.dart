import 'package:binance_f/core/db/app_database.dart';
import 'package:binance_f/features/markets/data/markets_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio spotDio;
  late MockDio futuresDio;
  late AppDatabase db;
  late BinanceMarketsRepository repo;

  setUp(() {
    spotDio = MockDio();
    futuresDio = MockDio();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = BinanceMarketsRepository(
      spotDio: () => spotDio,
      futuresDio: () => futuresDio,
      database: db,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('BinanceMarketsRepository', () {
    test('getExchangeInfo fetches spot symbols and caches them', () async {
      final mockData = {
        'symbols': [
          {
            'symbol': 'BTCUSDT',
            'status': 'TRADING',
            'baseAsset': 'BTC',
            'quoteAsset': 'USDT',
            'filters': [
              {
                'filterType': 'PRICE_FILTER',
                'minPrice': '0.01',
                'maxPrice': '100000.00',
                'tickSize': '0.01',
              },
            ],
          },
        ],
      };

      when(() => spotDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => Response(
          data: mockData,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await repo.getExchangeInfo(market: 'spot').run();

      expect(result.isRight(), isTrue);
      final symbols = result.getOrElse((_) => []);
      expect(symbols, hasLength(1));
      expect(symbols.first.symbol, 'BTCUSDT');

      // Verify caching (allow some time for the fire-and-forget call)
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final cached = await db.select(db.cachedSymbols).get();
      expect(cached, hasLength(1));
      expect(cached.first.symbol, 'BTCUSDT');
      expect(cached.first.market, 'spot');
    });

    test('getExchangeInfo fetches futures symbols (contractStatus)', () async {
      final mockData = {
        'symbols': [
          {
            'symbol': 'ETHUSDT',
            'contractStatus': 'TRADING',
            'baseAsset': 'ETH',
            'quoteAsset': 'USDT',
            'filters': [],
          },
        ],
      };

      when(() => futuresDio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => Response(
          data: mockData,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await repo.getExchangeInfo(market: 'futures').run();

      expect(result.isRight(), isTrue);
      final symbols = result.getOrElse((_) => []);
      expect(symbols.first.symbol, 'ETHUSDT');
      expect(symbols.first.status, 'TRADING');
    });

    test('get24hTickers fetches spot tickers successfully', () async {
      final mockData = [
        {
          'symbol': 'BTCUSDT',
          'lastPrice': '50000.00',
          'priceChange': '1000.00',
          'priceChangePercent': '2.0',
          'quoteVolume': '1000000.00',
          'volume': '100.00',
          'highPrice': '51000.00',
          'lowPrice': '49000.00',
        },
      ];

      when(() => spotDio.get<List<dynamic>>(any())).thenAnswer(
        (_) async => Response(
          data: mockData,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await repo.get24hTickers(market: 'spot').run();

      expect(result.isRight(), isTrue);
      final tickers = result.getOrElse((_) => []);
      expect(tickers, hasLength(1));
      expect(tickers.first.symbol, 'BTCUSDT');
      expect(tickers.first.lastPrice.toString(), '50000');
    });
  });
}
