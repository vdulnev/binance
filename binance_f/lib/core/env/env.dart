/// Runtime environment for Binance endpoints.
///
/// Phase 1 launched the env from `--dart-define=BINANCE_ENV=testnet`.
/// Phase 2 makes the selection mutable: persisted with credentials in
/// secure storage and switchable on the login screen. The `--dart-define`
/// remains as a fallback for first-run / cleared installs.
enum BinanceEnv { mainnet, testnet }

/// Resolved per-environment URLs for both spot and futures markets.
///
/// Spot endpoints live under [restBaseUrl] (`api.binance.com` /
/// `testnet.binance.vision`); futures endpoints live under
/// [futuresRestBaseUrl] (`fapi.binance.com` / `testnet.binancefuture.com`).
class Env {
  const Env._({
    required this.env,
    required this.restBaseUrl,
    required this.futuresRestBaseUrl,
    required this.wsBaseUrl,
    required this.futuresWsBaseUrl,
  });

  final BinanceEnv env;
  final String restBaseUrl;
  final String futuresRestBaseUrl;
  final String wsBaseUrl;
  final String futuresWsBaseUrl;

  bool get isTestnet => env == BinanceEnv.testnet;

  static const Env mainnet = Env._(
    env: BinanceEnv.mainnet,
    restBaseUrl: 'https://api.binance.com',
    futuresRestBaseUrl: 'https://fapi.binance.com',
    wsBaseUrl: 'wss://stream.binance.com:9443',
    futuresWsBaseUrl: 'wss://fstream.binance.com',
  );

  static const Env testnet = Env._(
    env: BinanceEnv.testnet,
    restBaseUrl: 'https://testnet.binance.vision',
    futuresRestBaseUrl: 'https://testnet.binancefuture.com',
    wsBaseUrl: 'wss://testnet.binance.vision',
    futuresWsBaseUrl: 'wss://stream.binancefuture.com',
  );

  static Env forEnum(BinanceEnv env) =>
      env == BinanceEnv.testnet ? testnet : mainnet;

  /// Compile-time fallback used when there is no persisted env yet
  /// (first launch, post-logout, post-clear). Defaults to mainnet.
  static const _envName = String.fromEnvironment(
    'BINANCE_ENV',
    defaultValue: 'mainnet',
  );

  static Env get fallback =>
      _envName.toLowerCase() == 'testnet' ? testnet : mainnet;
}
