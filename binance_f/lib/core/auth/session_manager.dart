import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talker/talker.dart';

import '../../features/favorites/data/favorites_repository.dart';
import '../../features/markets/data/market_ws_manager.dart';
import '../db/order_history_cache.dart';
import '../db/portfolio_cache.dart';
import '../env/env_manager.dart';
import '../models/app_exception.dart';
import '../ws/user_data_stream.dart';
import 'credentials_manager.dart';

/// Owns the lifecycle of a logged-in session.
///
/// Responsibilities:
/// - **restore()** — at app launch, reads the persisted env, applies it to
///   [EnvManager] (so the auth guard's first signed call hits the right
///   host), and reports whether credentials are present.
/// - **logout()** — full wipe per FR-1.6 / EC-15: cancels in-flight signed
///   requests, tears down WebSocket subscriptions (Phase 4 hook), clears
///   credentials and env, and resets [EnvManager] to the dart-define
///   fallback.
///
/// Repositories that issue signed requests should call
/// [registerCancelToken] when they own a long-lived token, so logout can
/// abort in-flight calls deterministically.
class SessionManager {
  SessionManager({
    required CredentialsManager credentialsManager,
    required EnvManager envManager,
    required Talker talker,
    UserDataStream? userDataStream,
    PortfolioCache? portfolioCache,
    OrderHistoryCache? orderHistoryCache,
    MarketWsManager? marketWsManager,
    FavoritesRepository? favoritesRepository,
  }) : _credentials = credentialsManager,
       _envManager = envManager,
       _talker = talker,
       _userDataStream = userDataStream,
       _portfolioCache = portfolioCache,
       _orderHistoryCache = orderHistoryCache,
       _marketWsManager = marketWsManager,
       _favoritesRepository = favoritesRepository;

  final CredentialsManager _credentials;
  final EnvManager _envManager;
  final Talker _talker;
  final UserDataStream? _userDataStream;
  final PortfolioCache? _portfolioCache;
  final OrderHistoryCache? _orderHistoryCache;
  final MarketWsManager? _marketWsManager;
  final FavoritesRepository? _favoritesRepository;

  final Set<CancelToken> _cancelTokens = <CancelToken>{};

  /// Registers a [CancelToken] so [logout] can abort the in-flight request
  /// owning it. The repository should remove the token when its request
  /// completes via [unregisterCancelToken].
  void registerCancelToken(CancelToken token) {
    _cancelTokens.add(token);
  }

  void unregisterCancelToken(CancelToken token) {
    _cancelTokens.remove(token);
  }

  TaskEither<AppException, bool> isSessionValid() =>
      _credentials.hasCredentials();

  TaskEither<AppException, Unit> invalidateSession() =>
      _credentials.clearCredentials();

  /// Loads the persisted env (if any), pushes it into [EnvManager], and
  /// reports whether the user has saved credentials. Called from
  /// `main.dart` BEFORE the router mounts so the auth guard runs against
  /// the right host.
  TaskEither<AppException, bool> restore() =>
      _credentials.getEnv().flatMap((maybeEnv) {
        if (maybeEnv != null) {
          _envManager.set(maybeEnv);
          _talker.info('SessionManager.restore: env=${maybeEnv.name} restored');
        } else {
          _talker.info(
            'SessionManager.restore: no persisted env, '
            'using fallback=${_envManager.current.env.name}',
          );
        }
        return _credentials.hasCredentials();
      });

  /// Full logout per FR-1.6 / EC-15.
  ///
  /// Steps (linear fpdart chain). Each step is best-effort; failures are
  /// logged via Talker but logout still proceeds, so the user can never
  /// get stuck mid-logout because of a stray storage error.
  ///
  /// 1. Cancel all in-flight Dio requests on every registered token.
  /// 2. Tear down the user data WebSockets (DELETE listen keys +
  ///    disconnect spot + futures sockets).
  /// 3. `clearCredentials()` — wipes key, secret, env.
  /// 4. Reset [EnvManager] to the `--dart-define` fallback so the next
  ///    launch picks the developer-expected env.
  /// 5. Wipe the `cached_portfolio` Drift table. Settings (theme + quote
  ///    asset) are intentionally preserved per spec §4.
  TaskEither<AppException, Unit> logout() =>
      TaskEither<AppException, Unit>(() async {
        _talker.info('SessionManager.logout: starting full wipe');

        // 1. Cancel in-flight signed requests.
        for (final token in _cancelTokens.toList()) {
          // CancelToken.cancel doesn't throw — safe to call without try.
          token.cancel('logout');
        }
        _cancelTokens.clear();

        // 2a. User data WebSocket teardown — stops listen-key refresh
        //     timer, DELETEs both listen keys, disconnects both sockets.
        final userStream = _userDataStream;
        if (userStream != null) {
          await userStream.stopAll();
          _talker.info('logout: user data streams stopped');
        }

        // 2b. Market WebSocket teardown — disconnects all per-symbol
        //     ticker/depth/trade/kline subscriptions (Phase 4).
        final marketWs = _marketWsManager;
        if (marketWs != null) {
          await marketWs.unsubscribeAll();
          _talker.info('logout: market WS streams stopped');
        }

        // 2c. Wipe favorites table (Phase 4). Settings are preserved.
        final favRepo = _favoritesRepository;
        if (favRepo is DriftFavoritesRepository) {
          final favResult = await favRepo.clearAll().run();
          favResult.match(
            (err) => _talker.error('logout: favorites clear failed', err),
            (_) => _talker.info('logout: favorites cleared'),
          );
        }

        // 3. Wipe credentials + env from secure storage.
        final clearResult = await _credentials.clearCredentials().run();
        clearResult.match(
          (err) => _talker.error('logout: clearCredentials failed', err),
          (_) => _talker.info('logout: credentials cleared'),
        );

        // 4. Reset env to the dart-define fallback.
        _envManager.reset();

        // 5. Wipe cached portfolio. Best-effort — failures are logged
        //    but don't abort logout. Settings table (theme + quote
        //    asset) is preserved by design.
        final cache = _portfolioCache;
        if (cache != null) {
          final cacheResult = await cache.clear().run();
          cacheResult.match(
            (err) => _talker.error('logout: portfolio cache clear failed', err),
            (_) => _talker.info('logout: portfolio cache cleared'),
          );
        }

        // 6. Wipe cached order history (Phase 8).
        final orderCache = _orderHistoryCache;
        if (orderCache != null) {
          final orderCacheResult = await orderCache.clear().run();
          orderCacheResult.match(
            (err) =>
                _talker.error('logout: order history cache clear failed', err),
            (_) => _talker.info('logout: order history cache cleared'),
          );
        }

        _talker.info('SessionManager.logout: complete');
        return right(unit);
      });
}
