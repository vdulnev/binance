import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

import 'env.dart';

/// Identifier for the Binance market a Dio instance targets.
///
/// Spot points at `api.binance.com` / `testnet.binance.vision` and futures
/// at `fapi.binance.com` / `testnet.binancefuture.com`.
enum BinanceMarket { spot, futures }

/// Function shape used by [EnvManager] to (re)build a Dio for a given env
/// and market. The bootstrap in `service_locator.dart` wires this to
/// `createBinanceClient` so the interceptor chain stays in one place.
typedef DioFactory = Dio Function(Env env, BinanceMarket market);

/// Holds the *currently active* [Env] and the spot/futures [Dio] instances
/// it built. On [set] the manager swaps the env, builds fresh Dios, and
/// closes the old ones with `force: true` so any in-flight signed request
/// gets cancelled rather than silently hitting the previous host.
///
/// Switching env is treated as a destructive operation: the spec (EC-11)
/// requires logout before changing environments while logged in. The login
/// flow calls [set] BEFORE saving credentials so the verification request
/// already targets the new host. Anything else that wants to change env
/// must go through logout first.
class EnvManager {
  EnvManager({required DioFactory dioFactory, required Talker talker})
    : _dioFactory = dioFactory,
      _talker = talker,
      _current = Env.fallback {
    _spot = _dioFactory(_current, BinanceMarket.spot);
    _futures = _dioFactory(_current, BinanceMarket.futures);
  }

  final DioFactory _dioFactory;
  final Talker _talker;

  Env _current;
  late Dio _spot;
  late Dio _futures;

  Env get current => _current;

  Dio get spot => _spot;

  Dio get futures => _futures;

  /// Switches the active environment. Builds two fresh Dio instances and
  /// disposes the previous ones with `force: true` so any in-flight signed
  /// request is cancelled instead of silently hitting the previous host.
  ///
  /// EC-11: callers must already have logged the user out (or be in the
  /// middle of logging in) before calling this. There is no in-app runtime
  /// toggle while logged in.
  void set(BinanceEnv env) {
    final next = Env.forEnum(env);
    if (next.env == _current.env) return;

    _talker.info(
      'EnvManager switching ${_current.env.name} → ${next.env.name}',
    );
    final oldSpot = _spot;
    final oldFutures = _futures;

    _current = next;
    _spot = _dioFactory(next, BinanceMarket.spot);
    _futures = _dioFactory(next, BinanceMarket.futures);

    oldSpot.close(force: true);
    oldFutures.close(force: true);
  }

  /// Resets to the compile-time fallback (`--dart-define=BINANCE_ENV=...`,
  /// or mainnet). Used by logout so the next launch picks the same env the
  /// developer expects after wiping credentials.
  void reset() => set(Env.fallback.env);
}
