import 'package:binance_f/features/chart/data/chart_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio spotDio;
  late MockDio futuresDio;
  late BinanceChartRepository repo;

  setUp(() {
    spotDio = MockDio();
    futuresDio = MockDio();
    repo = BinanceChartRepository(
      spotDio: () => spotDio,
      futuresDio: () => futuresDio,
    );
  });

  group('BinanceChartRepository.getKlines', () {
    final mockResponse = [
      [
        1499040000000, // Open time
        "0.01634790", // Open
        "0.80000000", // High
        "0.01575800", // Low
        "0.01577100", // Close
        "148976.11427815", // Volume
        1499644799999, // Close time
        "2434.19055334", // Quote asset volume
        308, // Number of trades
        "1756.87402397", // Taker buy base asset volume
        "28.46694368", // Taker buy quote asset volume
        "17928899.62484339", // Ignore
      ],
    ];

    test('fetches spot klines successfully', () async {
      when(
        () => spotDio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await repo
          .getKlines(symbol: 'BTCUSDT', market: 'spot', interval: '1m')
          .run();

      expect(result.isRight(), isTrue);
      final list = result.getOrElse((_) => []);
      expect(list.length, 1);
      expect(list.first.open, 0.01634790);
      expect(list.first.time, 1499040000000);

      verify(
        () => spotDio.get<List<dynamic>>(
          '/api/v3/klines',
          queryParameters: {
            'symbol': 'BTCUSDT',
            'interval': '1m',
            'limit': 500,
          },
        ),
      ).called(1);
    });

    test('fetches futures klines successfully', () async {
      when(
        () => futuresDio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await repo
          .getKlines(symbol: 'BTCUSDT', market: 'futures', interval: '1h')
          .run();

      expect(result.isRight(), isTrue);
      verify(
        () => futuresDio.get<List<dynamic>>(
          '/fapi/v1/klines',
          queryParameters: {
            'symbol': 'BTCUSDT',
            'interval': '1h',
            'limit': 500,
          },
        ),
      ).called(1);
    });

    test('returns AppException on Dio error', () async {
      when(
        () => spotDio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result = await repo
          .getKlines(symbol: 'BTCUSDT', market: 'spot', interval: '1m')
          .run();

      expect(result.isLeft(), isTrue);
    });
  });
}
