import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/chart/data/chart_repository.dart';
import '../../features/favorites/data/favorites_repository.dart';
import '../../features/history/data/order_history_repository.dart';
import '../../features/markets/data/market_ws_manager.dart';
import '../../features/markets/data/markets_repository.dart';
import '../../features/orderbook/data/orderbook_repository.dart';
import '../../features/portfolio/data/portfolio_repository.dart';
import '../../features/trade/data/futures_trade_repository.dart';
import '../../features/trade/data/spot_trade_repository.dart';
import '../api/binance_client.dart';
import '../api/signing_interceptor.dart';
import '../auth/credentials_manager.dart';
import '../auth/session_manager.dart';
import '../db/app_database.dart';
import '../db/order_history_cache.dart';
import '../db/portfolio_cache.dart';
import '../env/env_manager.dart';
import '../logging/app_talker.dart';
import '../router/app_router.dart';
import '../router/auth_guard.dart';
import '../security/secure_storage_service.dart';
import '../ws/user_data_stream.dart';

final sl = GetIt.instance;

const kSpot = 'spot';
const kFutures = 'futures';

Future<void> initServiceLocator() async {
  // Logging
  sl.registerLazySingleton<Talker>(createAppTalker);

  // Security
  sl.registerLazySingleton<SecureStorageService>(
    FlutterSecureStorageService.new,
  );

  // Auth — credentials manager comes before EnvManager so the latter can
  // be constructed without depending on Dio (avoids a cycle).
  sl.registerLazySingleton<CredentialsManager>(
    () => CredentialsManager(storage: sl<SecureStorageService>()),
  );

  // Single shared SigningInterceptor across spot + futures so the lazy
  // /api/v3/time offset is computed once for the whole session.
  sl.registerLazySingleton<SigningInterceptor>(
    () => SigningInterceptor(storage: sl<SecureStorageService>()),
  );

  // EnvManager owns the active env and the spot/futures Dio pair.
  // It rebuilds both Dios on `set()` and disposes the old ones.
  sl.registerLazySingleton<EnvManager>(
    () => EnvManager(
      talker: sl<Talker>(),
      dioFactory: (env, market) => createBinanceClient(
        env: env,
        market: market,
        signing: sl<SigningInterceptor>(),
        talker: sl<Talker>(),
      ),
    ),
  );

  // Two named Dio facades over EnvManager. Repositories ask get_it for the
  // one they need; the underlying Dio is swapped out by EnvManager when env
  // changes, but get_it keeps handing back the live reference because we
  // resolve `.spot` / `.futures` lazily on every read.
  //
  // get_it can't natively forward "give me the current spot Dio" because
  // factory registrations cache by instance identity. Use a factory so the
  // lookup runs through EnvManager every time.
  sl.registerFactory<Dio>(() => sl<EnvManager>().spot, instanceName: kSpot);
  sl.registerFactory<Dio>(
    () => sl<EnvManager>().futures,
    instanceName: kFutures,
  );

  // Drift database + portfolio cache. `AppDatabase` is opened lazily on
  // first access via get_it — tests override it with an in-memory
  // executor via `sl.registerSingleton<AppDatabase>(...)` in setUp.
  sl.registerLazySingleton<AppDatabase>(AppDatabase.new);
  sl.registerLazySingleton<PortfolioCache>(
    () => PortfolioCache(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<OrderHistoryCache>(
    () => OrderHistoryCache(database: sl<AppDatabase>()),
  );

  // Market WebSocket manager — per-symbol WS streams (ticker, depth,
  // trade, kline). Logout calls `unsubscribeAll()` via SessionManager.
  sl.registerLazySingleton<MarketWsManager>(
    () => MarketWsManager(envManager: sl<EnvManager>(), talker: sl<Talker>()),
  );

  // User data WebSocket stream (spot + futures listen keys). Wired here
  // so `SessionManager.logout` can `.stopAll()` it as part of full wipe.
  sl.registerLazySingleton<UserDataStream>(
    () => UserDataStream(
      listenKeyClient: BinanceListenKeyClient(
        spot: () => sl<Dio>(instanceName: kSpot),
        futures: () => sl<Dio>(instanceName: kFutures),
      ),
      envManager: sl<EnvManager>(),
      talker: sl<Talker>(),
    ),
  );

  // Session manager depends on EnvManager so it can swap env on restore /
  // reset on logout. It also takes the UserDataStream + PortfolioCache +
  // MarketWsManager so logout can tear down live subscriptions and wipe
  // cached data.
  sl.registerLazySingleton<SessionManager>(
    () => SessionManager(
      credentialsManager: sl<CredentialsManager>(),
      envManager: sl<EnvManager>(),
      talker: sl<Talker>(),
      userDataStream: sl<UserDataStream>(),
      portfolioCache: sl<PortfolioCache>(),
      orderHistoryCache: sl<OrderHistoryCache>(),
      marketWsManager: sl<MarketWsManager>(),
      favoritesRepository: sl<FavoritesRepository>(),
    ),
  );

  // Repositories — pass a `Dio` provider, not a captured Dio, so an env
  // switch (which rebuilds the Dio inside EnvManager) is observed without
  // having to re-register the repository.
  sl.registerLazySingleton<AuthRepository>(
    () => BinanceAuthRepository(
      dio: () => sl<Dio>(instanceName: kSpot),
      sessionManager: sl<SessionManager>(),
    ),
  );

  sl.registerLazySingleton<PortfolioRepository>(
    () => BinancePortfolioRepository(
      spotDio: () => sl<Dio>(instanceName: kSpot),
      futuresDio: () => sl<Dio>(instanceName: kFutures),
      sessionManager: sl<SessionManager>(),
    ),
  );

  sl.registerLazySingleton<MarketsRepository>(
    () => BinanceMarketsRepository(
      spotDio: () => sl<Dio>(instanceName: kSpot),
      futuresDio: () => sl<Dio>(instanceName: kFutures),
      database: sl<AppDatabase>(),
    ),
  );

  sl.registerLazySingleton<ChartRepository>(
    () => BinanceChartRepository(
      spotDio: () => sl<Dio>(instanceName: kSpot),
      futuresDio: () => sl<Dio>(instanceName: kFutures),
    ),
  );

  sl.registerLazySingleton<FavoritesRepository>(
    () => DriftFavoritesRepository(database: sl<AppDatabase>()),
  );

  sl.registerLazySingleton<OrderBookRepository>(
    () =>
        BinanceOrderBookRepository(spotDio: () => sl<Dio>(instanceName: kSpot)),
  );

  sl.registerLazySingleton<SpotTradeRepository>(
    () => BinanceSpotTradeRepository(
      spotDio: () => sl<Dio>(instanceName: kSpot),
      sessionManager: sl<SessionManager>(),
    ),
  );

  sl.registerLazySingleton<FuturesTradeRepository>(
    () => BinanceFuturesTradeRepository(
      futuresDio: () => sl<Dio>(instanceName: kFutures),
      sessionManager: sl<SessionManager>(),
    ),
  );

  sl.registerLazySingleton<OrderHistoryRepository>(
    () => BinanceOrderHistoryRepository(
      spotDio: () => sl<Dio>(instanceName: kSpot),
      futuresDio: () => sl<Dio>(instanceName: kFutures),
      sessionManager: sl<SessionManager>(),
    ),
  );

  // Router
  sl.registerLazySingleton<AppRouter>(
    () => AppRouter(authGuard: AuthGuard(sessionManager: sl<SessionManager>())),
  );
}
