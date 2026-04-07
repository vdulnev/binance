import 'package:binance_f/core/errors/error_action.dart';
import 'package:binance_f/core/errors/error_surface.dart';
import 'package:binance_f/core/models/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('errorActionFor', () {
    test('Auth → ForceRelogin', () {
      expect(
        errorActionFor(const AppException.auth(message: 'bad key')),
        isA<ForceRelogin>(),
      );
    });

    test('InvalidSignature → ForceRelogin', () {
      expect(
        errorActionFor(const AppException.invalidSignature()),
        isA<ForceRelogin>(),
      );
    });

    test('IpBan → BlockUi', () {
      expect(
        errorActionFor(const AppException.ipBan(message: 'banned')),
        isA<BlockUi>(),
      );
    });

    test('RateLimit → ShowSnackbar', () {
      expect(
        errorActionFor(const AppException.rateLimit(message: 'slow down')),
        isA<ShowSnackbar>(),
      );
    });

    test('FilterViolation → ShowSnackbar with filter name', () {
      final action = errorActionFor(
        const AppException.filterViolation(
          filter: 'LOT_SIZE',
          message: 'too small',
        ),
      );
      expect(action, isA<ShowSnackbar>());
      expect((action as ShowSnackbar).message, contains('LOT_SIZE'));
    });

    test('Network(retriable) → ShowSnackbar', () {
      expect(
        errorActionFor(const AppException.network(retriable: true)),
        isA<ShowSnackbar>(),
      );
    });

    test('ClockSkew → ShowSnackbar', () {
      expect(
        errorActionFor(const AppException.clockSkew()),
        isA<ShowSnackbar>(),
      );
    });

    test('BinanceApi → ShowSnackbar', () {
      expect(
        errorActionFor(
          const AppException.binanceApi(code: -1100, message: 'oops'),
        ),
        isA<ShowSnackbar>(),
      );
    });

    test('Unknown → ShowSnackbar', () {
      expect(errorActionFor(const AppException.unknown()), isA<ShowSnackbar>());
    });
  });
}
