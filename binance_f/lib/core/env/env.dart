/// Runtime environment for Binance endpoints.
///
/// Selected at app launch via `--dart-define=BINANCE_ENV=testnet`.
/// Defaults to mainnet.
enum BinanceEnv { mainnet, testnet }

class Env {
  const Env._({
    required this.env,
    required this.restBaseUrl,
    required this.wsBaseUrl,
  });

  final BinanceEnv env;
  final String restBaseUrl;
  final String wsBaseUrl;

  bool get isTestnet => env == BinanceEnv.testnet;

  static const _envName = String.fromEnvironment(
    'BINANCE_ENV',
    defaultValue: 'mainnet',
  );

  static final Env current = _envName.toLowerCase() == 'testnet'
      ? const Env._(
          env: BinanceEnv.testnet,
          restBaseUrl: 'https://testnet.binance.vision',
          wsBaseUrl: 'wss://testnet.binance.vision',
        )
      : const Env._(
          env: BinanceEnv.mainnet,
          restBaseUrl: 'https://api.binance.com',
          wsBaseUrl: 'wss://stream.binance.com:9443',
        );
}
