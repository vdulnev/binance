import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/trade/data/filter_validator.dart';
import 'package:binance_f/features/trade/data/models/symbol_filters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

Decimal d(String s) => Decimal.parse(s);

void main() {
  final filters = SymbolFilters(
    symbol: 'BTCUSDT',
    tickSize: d('0.01'),
    stepSize: d('0.0001'),
    minQty: d('0.0001'),
    minNotional: d('10'),
  );

  /// Helper: assert the result is a `Left(FilterViolationException)` whose
  /// `filter` field equals [expectedFilter].
  void expectFilterViolation(
    Either<AppException, Unit> result,
    String expectedFilter,
  ) {
    expect(
      result.isLeft(),
      isTrue,
      reason: 'expected Left for $expectedFilter',
    );
    result.match((err) {
      expect(err, isA<FilterViolationException>());
      expect((err as FilterViolationException).filter, expectedFilter);
    }, (_) => fail('expected Left($expectedFilter), got Right'));
  }

  group('validateOrder', () {
    test('passes a valid order → Right(unit)', () {
      final result = validateOrder(
        filters: filters,
        price: d('30000.00'),
        quantity: d('0.0010'),
      );
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => unit), unit);
    });

    test('tick size violation → Left(FilterViolation(PRICE_FILTER))', () {
      final result = validateOrder(
        filters: filters,
        price: d('30000.005'),
        quantity: d('0.001'),
      );
      expectFilterViolation(result, 'PRICE_FILTER');
    });

    test('lot size step violation → Left(FilterViolation(LOT_SIZE))', () {
      final result = validateOrder(
        filters: filters,
        price: d('30000.00'),
        quantity: d('0.00015'),
      );
      expectFilterViolation(result, 'LOT_SIZE');
    });

    test('min notional violation → Left(FilterViolation(MIN_NOTIONAL))', () {
      final result = validateOrder(
        filters: filters,
        price: d('30000.00'),
        quantity: d('0.0001'),
      );
      expectFilterViolation(result, 'MIN_NOTIONAL');
    });
  });
}
