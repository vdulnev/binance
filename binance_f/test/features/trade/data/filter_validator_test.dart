import 'package:binance_f/core/models/app_exception.dart';
import 'package:binance_f/features/trade/data/filter_validator.dart';
import 'package:binance_f/features/trade/data/models/symbol_filters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

Decimal d(String s) => Decimal.parse(s);

void main() {
  final filters = SymbolFilters(
    symbol: 'BTCUSDT',
    tickSize: d('0.01'),
    stepSize: d('0.0001'),
    minQty: d('0.0001'),
    minNotional: d('10'),
  );

  group('validateOrder', () {
    test('passes a valid order', () {
      validateOrder(
        filters: filters,
        price: d('30000.00'),
        quantity: d('0.0010'),
      );
    });

    test('tick size violation raises FilterViolation(PRICE_FILTER)', () {
      expect(
        () => validateOrder(
          filters: filters,
          price: d('30000.005'),
          quantity: d('0.001'),
        ),
        throwsA(
          isA<FilterViolationException>().having(
            (e) => e.filter,
            'filter',
            'PRICE_FILTER',
          ),
        ),
      );
    });

    test('lot size step violation raises FilterViolation(LOT_SIZE)', () {
      expect(
        () => validateOrder(
          filters: filters,
          price: d('30000.00'),
          quantity: d('0.00015'),
        ),
        throwsA(
          isA<FilterViolationException>().having(
            (e) => e.filter,
            'filter',
            'LOT_SIZE',
          ),
        ),
      );
    });

    test('min notional violation raises FilterViolation(MIN_NOTIONAL)', () {
      expect(
        () => validateOrder(
          filters: filters,
          price: d('30000.00'),
          quantity: d('0.0001'),
        ),
        throwsA(
          isA<FilterViolationException>().having(
            (e) => e.filter,
            'filter',
            'MIN_NOTIONAL',
          ),
        ),
      );
    });
  });
}
