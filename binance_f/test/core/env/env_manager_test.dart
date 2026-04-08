import 'package:binance_f/core/env/env.dart';
import 'package:binance_f/core/env/env_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';

/// Tracks every Dio the factory hands out so the test can assert lifecycle.
/// We can't `extends Dio` (Dio only exposes factory constructors), so use
/// `Fake implements Dio` and just stub the bits the manager touches:
/// `options.baseUrl` and `close(force:)`.
class _BuiltDio extends Fake implements Dio {
  _BuiltDio({required this.env, required this.market});

  final Env env;
  final BinanceMarket market;
  bool closed = false;
  bool closedForce = false;

  @override
  late final BaseOptions options = BaseOptions(
    baseUrl: market == BinanceMarket.futures
        ? env.futuresRestBaseUrl
        : env.restBaseUrl,
  );

  @override
  void close({bool force = false}) {
    closed = true;
    closedForce = force;
  }
}

void main() {
  late List<_BuiltDio> built;
  late EnvManager manager;

  Dio factory(Env env, BinanceMarket market) {
    final d = _BuiltDio(env: env, market: market);
    built.add(d);
    return d;
  }

  setUp(() {
    built = <_BuiltDio>[];
    manager = EnvManager(dioFactory: factory, talker: Talker());
  });

  group('EnvManager', () {
    test('starts on the fallback env (mainnet by default in tests)', () {
      expect(manager.current.env, BinanceEnv.mainnet);
      expect(manager.spot.options.baseUrl, 'https://api.binance.com');
      expect(manager.futures.options.baseUrl, 'https://fapi.binance.com');
    });

    test(
      'set(testnet) swaps current, rebuilds spot+futures, closes old Dios',
      () {
        final oldSpot = manager.spot as _BuiltDio;
        final oldFutures = manager.futures as _BuiltDio;

        manager.set(BinanceEnv.testnet);

        expect(manager.current.env, BinanceEnv.testnet);
        expect(manager.spot.options.baseUrl, 'https://testnet.binance.vision');
        expect(
          manager.futures.options.baseUrl,
          'https://testnet.binancefuture.com',
        );

        // Old Dios were closed with force=true so any in-flight signed
        // request gets cancelled instead of silently hitting the previous
        // host.
        expect(oldSpot.closed, isTrue);
        expect(oldSpot.closedForce, isTrue);
        expect(oldFutures.closed, isTrue);
        expect(oldFutures.closedForce, isTrue);
      },
    );

    test('set(sameEnv) is a no-op — no rebuild, old Dios untouched', () {
      final oldSpot = manager.spot as _BuiltDio;
      final oldFutures = manager.futures as _BuiltDio;
      final builtBefore = built.length;

      manager.set(BinanceEnv.mainnet);

      expect(built.length, builtBefore, reason: 'no rebuild');
      expect(oldSpot.closed, isFalse);
      expect(oldFutures.closed, isFalse);
      expect(identical(manager.spot, oldSpot), isTrue);
      expect(identical(manager.futures, oldFutures), isTrue);
    });

    test('set rebuilds both spot AND futures when env changes', () {
      manager.set(BinanceEnv.testnet);
      // 2 from constructor + 2 from set
      expect(built.length, 4);
      expect(built[2].market, BinanceMarket.spot);
      expect(built[3].market, BinanceMarket.futures);
      expect(built[2].env.env, BinanceEnv.testnet);
      expect(built[3].env.env, BinanceEnv.testnet);
    });

    test('reset() returns to fallback env', () {
      manager.set(BinanceEnv.testnet);
      expect(manager.current.env, BinanceEnv.testnet);

      manager.reset();
      expect(manager.current.env, BinanceEnv.mainnet);
    });
  });
}
