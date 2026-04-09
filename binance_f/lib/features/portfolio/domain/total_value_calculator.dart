import 'package:decimal/decimal.dart';

import '../data/models/futures_asset_balance.dart';
import '../data/models/spot_balance.dart';
import 'total_value_result.dart';

/// Computes the aggregate portfolio value across spot balances and
/// futures assets, denominated in [quoteAsset].
///
/// ### Rules (FR-2.2)
///
/// For each non-zero asset:
/// 1. If the asset equals [quoteAsset], contribute its amount directly.
/// 2. Otherwise look up `<asset><quoteAsset>` in [prices] and multiply.
/// 3. If that direct pair is missing, look up `<quoteAsset><asset>` and
///    multiply by the inverse (`amount / price`).
/// 4. If still missing, **skip** the asset — do not fail the whole
///    calculation. Record it in [TotalValueResult.skippedAssets] so the UI
///    can note which rows weren't priced in.
///
/// The spot contribution uses [SpotBalance.total] (`free + locked`).
/// The futures contribution uses [FuturesAssetBalance.marginBalance], which
/// Binance already computes as `walletBalance + unrealizedProfit`.
///
/// The result is floored to 8 decimal places — Binance's own UI rarely
/// surfaces more precision than that and it keeps the UI tidy without
/// losing material value.
TotalValueResult computeTotalInQuote({
  required Iterable<SpotBalance> spotBalances,
  required Iterable<FuturesAssetBalance> futuresAssets,
  required Map<String, Decimal> prices,
  String quoteAsset = 'USDT',
}) {
  var total = Decimal.zero;
  final skipped = <String>{};

  void addContribution(String asset, Decimal amount) {
    if (amount == Decimal.zero) return;

    if (asset == quoteAsset) {
      total += amount;
      return;
    }

    final direct = prices['$asset$quoteAsset'];
    if (direct != null) {
      total += amount * direct;
      return;
    }

    final inverse = prices['$quoteAsset$asset'];
    if (inverse != null && inverse != Decimal.zero) {
      // amount * (1 / inverse) — use Rational then floor back to Decimal
      // so we don't lose precision on non-terminating quotients.
      final rational = amount.toRational() / inverse.toRational();
      total += rational.toDecimal(scaleOnInfinitePrecision: 18);
      return;
    }

    skipped.add(asset);
  }

  for (final b in spotBalances) {
    addContribution(b.asset, b.total);
  }

  for (final a in futuresAssets) {
    addContribution(a.asset, a.marginBalance);
  }

  // Floor to 8 decimals. `Decimal.round(scale:)` rounds half-up, so to
  // truly floor we step through the Rational.
  final floored = _floor(total, 8);

  return TotalValueResult(
    total: floored,
    quoteAsset: quoteAsset,
    skippedAssets: skipped.toList()..sort(),
  );
}

/// Floors [value] to [scale] decimal places.
Decimal _floor(Decimal value, int scale) {
  if (value == Decimal.zero) return Decimal.zero;
  final shift = Decimal.ten.pow(scale).toDecimal();
  final shifted = (value * shift).floor();
  return (shifted.toRational() / shift.toRational()).toDecimal(
    scaleOnInfinitePrecision: scale,
  );
}
