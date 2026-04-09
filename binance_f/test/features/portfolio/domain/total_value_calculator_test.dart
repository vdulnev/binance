import 'package:binance_f/features/portfolio/data/models/futures_asset_balance.dart';
import 'package:binance_f/features/portfolio/data/models/spot_balance.dart';
import 'package:binance_f/features/portfolio/domain/total_value_calculator.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

Decimal d(String v) => Decimal.parse(v);

SpotBalance spot(String asset, String free, [String locked = '0']) =>
    SpotBalance(asset: asset, free: d(free), locked: d(locked));

FuturesAssetBalance fut(String asset, String marginBalance) =>
    FuturesAssetBalance(
      asset: asset,
      walletBalance: d(marginBalance),
      unrealizedProfit: Decimal.zero,
      marginBalance: d(marginBalance),
      availableBalance: d(marginBalance),
    );

void main() {
  group('computeTotalInQuote', () {
    test('quote asset (USDT) is added directly without a price lookup', () {
      final result = computeTotalInQuote(
        spotBalances: [spot('USDT', '100.5')],
        futuresAssets: [fut('USDT', '50')],
        prices: const {},
      );

      expect(result.total, d('150.5'));
      expect(result.quoteAsset, 'USDT');
      expect(result.skippedAssets, isEmpty);
    });

    test('direct pair lookup: BTC -> BTCUSDT', () {
      // 2 BTC at 30000 = 60000 USDT
      final result = computeTotalInQuote(
        spotBalances: [spot('BTC', '2')],
        futuresAssets: const [],
        prices: {'BTCUSDT': d('30000')},
      );

      expect(result.total, d('60000'));
      expect(result.skippedAssets, isEmpty);
    });

    test('inverse pair lookup: USDC when only USDCUSDT missing uses quote inverse', () {
      // Suppose the API only lists `USDTUSDC` for some reason — we should
      // invert: 10 USDC @ USDTUSDC=0.5 → 10 / 0.5 = 20 USDT.
      final result = computeTotalInQuote(
        spotBalances: [spot('USDC', '10')],
        futuresAssets: const [],
        prices: {'USDTUSDC': d('0.5')},
      );

      expect(result.total, d('20'));
      expect(result.skippedAssets, isEmpty);
    });

    test('missing symbol: asset is skipped, total still produced', () {
      final result = computeTotalInQuote(
        spotBalances: [spot('BTC', '1'), spot('XYZ', '100')],
        futuresAssets: const [],
        prices: {'BTCUSDT': d('30000')},
      );

      expect(result.total, d('30000'));
      expect(result.skippedAssets, ['XYZ']);
    });

    test('zero balances are ignored entirely', () {
      final result = computeTotalInQuote(
        spotBalances: [spot('BTC', '0', '0'), spot('ETH', '0')],
        futuresAssets: [fut('USDT', '0')],
        prices: {'BTCUSDT': d('30000'), 'ETHUSDT': d('2000')},
      );

      expect(result.total, Decimal.zero);
      expect(result.skippedAssets, isEmpty);
    });

    test('futures assets contribute via marginBalance', () {
      final result = computeTotalInQuote(
        spotBalances: const [],
        futuresAssets: [fut('USDT', '1000'), fut('BTC', '0.5')],
        prices: {'BTCUSDT': d('30000')},
      );

      // 1000 USDT + (0.5 BTC * 30000) = 16000 USDT
      expect(result.total, d('16000'));
    });

    test('result total is floored to 8 decimals', () {
      // 1 / 3 in the quote asset ≈ 0.33333333333...
      final result = computeTotalInQuote(
        spotBalances: [spot('BTC', '1')],
        futuresAssets: const [],
        prices: {'BTCUSDT': d('0.33333333333333333')},
      );
      // Floor to 8 dp → 0.33333333
      expect(result.total, d('0.33333333'));
    });

    test('both free and locked count toward the contribution', () {
      final result = computeTotalInQuote(
        spotBalances: [spot('USDT', '10', '5')],
        futuresAssets: const [],
        prices: const {},
      );
      expect(result.total, d('15'));
    });

    test('custom quote asset (BTC) is honored', () {
      final result = computeTotalInQuote(
        spotBalances: [spot('BTC', '2'), spot('ETH', '10')],
        futuresAssets: const [],
        prices: {'ETHBTC': d('0.06')},
        quoteAsset: 'BTC',
      );
      // 2 BTC + 10 ETH * 0.06 = 2.6 BTC
      expect(result.total, d('2.6'));
      expect(result.quoteAsset, 'BTC');
    });

    test('skippedAssets is de-duplicated and sorted', () {
      final result = computeTotalInQuote(
        spotBalances: [spot('ZZZ', '1'), spot('AAA', '1'), spot('ZZZ', '2')],
        futuresAssets: [fut('MMM', '1')],
        prices: const {},
      );
      expect(result.total, Decimal.zero);
      expect(result.skippedAssets, ['AAA', 'MMM', 'ZZZ']);
    });
  });
}
