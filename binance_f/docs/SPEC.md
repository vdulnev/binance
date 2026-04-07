# Flutter Implementation Spec — Binance Client (`binance_f`)

This document specifies the Flutter implementation of the Binance client. It complements the parent product spec at `../../docs/SPEC.md`, which is the source of truth for product scope, user stories, functional requirements, and API contracts. This file only describes *how* the Flutter app realizes that spec.

If anything here conflicts with the parent spec, the parent spec wins for behavior and this file wins for Flutter-specific implementation details.

---

## 1. Tech Stack

| Concern | Choice | Notes |
|---|---|---|
| Language | Dart ≥ 3.11.1 | null-safe, records, patterns |
| Framework | Flutter (stable) | Material 3 |
| State management | **Riverpod** (`flutter_riverpod`) | `Notifier` / `AsyncNotifier` providers |
| Routing | **auto_route** | code-gen, typed routes, guards |
| DI / service location | **get_it** | registered in `lib/core/di/` |
| Functional programming | **fpdart** | error handling |
| Logging | **Talker** + custom redacting Dio logger + `talker_flutter` | in-process redaction of secrets |
| Models / unions | **Freezed** + `json_serializable` | sealed classes for state + DTOs |
| HTTP | **Dio** | with custom interceptors |
| WebSocket | **web_socket_channel** | Dio is HTTP-only |
| Secure storage | **flutter_secure_storage** | Keychain (Apple), Keystore (Android), libsecret/DPAPI (Linux/Windows) |
| Local DB | **drift** (SQLite) | favorites, cached portfolio + history, alerts, settings |
| Simple prefs | **shared_preferences** | non-sensitive UI-only flags |
| Charting | **k_chart_plus** | candles + indicators + drawings |
| Notifications | **awesome_notifications** | local price alerts |
| Mocking (tests) | **mocktail** | per project test convention |

### Target platforms

iOS, Android, macOS, Windows, Linux. Web is **not** a target (secure storage + WebSocket + background alerts constraints).

Per-platform notes:
- **macOS**: Requires `com.apple.security.keychain-access-groups` and `com.apple.security.network.client` in both `DebugProfile.entitlements` and `Release.entitlements`.
- **Windows/Linux**: `flutter_secure_storage` uses DPAPI / libsecret; verify on first run.
- **Android**: `minSdk ≥ 23` for `flutter_secure_storage` AES.

---

## 2. Project Structure

Feature-first. Cross-cutting code lives in `lib/core/`.

```
lib/
├── main.dart                      # bootstrap: DI → Talker → Router → ProviderScope
├── app.dart                       # MaterialApp.router
├── core/
│   ├── di/service_locator.dart    # get_it registrations
│   ├── api/
│   │   ├── binance_client.dart    # Dio factory (spot + futures variants)
│   │   ├── signing_interceptor.dart
│   │   ├── rate_limit_interceptor.dart
│   │   ├── error_interceptor.dart
│   │   └── redacting_dio_logger.dart
│   ├── auth/
│   │   ├── credentials_manager.dart
│   │   └── session_manager.dart
│   ├── security/
│   │   ├── secure_storage_service.dart
│   │   └── crypto_utils.dart
│   ├── ws/
│   │   ├── ws_client.dart         # reconnect, backoff, ping
│   │   └── user_data_stream.dart  # listenKey lifecycle (spot + futures)
│   ├── db/
│   │   ├── app_database.dart      # drift
│   │   └── tables/
│   ├── logging/talker.dart
│   ├── routing/
│   │   ├── app_router.dart        # @AutoRouterConfig
│   │   └── auth_guard.dart
│   ├── env/env.dart               # mainnet ↔ testnet, spot + futures base URLs
│   ├── models/app_exception.dart  # sealed Freezed union
│   └── theme/app_theme.dart
└── features/
    ├── auth/        {data,providers,widgets}   # login, env picker, logout
    ├── portfolio/   {data,providers,widgets}   # spot + futures balances, total value
    ├── markets/     {data,providers,widgets}   # full symbol list, ticker
    ├── favorites/   {data,providers,widgets}   # user-editable favorites
    ├── symbol/      {data,providers,widgets}   # detail: chart + book + trades
    ├── chart/       {data,providers,widgets}   # k_chart_plus wrapper, indicators, drawings
    ├── orderbook/   {data,providers,widgets}
    ├── trade/       {data,providers,widgets}   # spot + futures order tickets
    ├── orders/      {data,providers,widgets}   # open + history, reconcile
    ├── alerts/      {data,providers,widgets}   # price alerts + notifications
    ├── transfers/   {data,providers,widgets}   # deposit/withdrawal history, addresses (view-only)
    └── settings/    {data,providers,widgets}   # theme, quote asset, logout
```

Each feature folder layout:
```
features/<feature>/
├── data/
│   ├── models/        # Freezed DTOs + .g.dart + .freezed.dart
│   └── <feature>_repository.dart
├── providers/         # Riverpod notifiers + state
└── widgets/           # screens + sub-widgets, one per file
```

Tests mirror `lib/` under `test/`.

---

## 3. Architecture Conventions

### Layered responsibilities
- **Widgets**: render + dispatch. No direct repository or Dio access. Read providers via `ref.watch` / `ref.listen`.
- **Providers (Riverpod)**: hold state, expose actions, call repositories. Use `AsyncNotifier` for anything that loads.
- **Repositories**: own a `Dio` (or `WsClient`), parse DTOs, throw typed `AppException`s. No Flutter imports.
- **Models**: Freezed only; no logic beyond `fromJson` / computed getters.

### Riverpod rules
- Use `late`, not `late final`, for fields initialized in `build()` — Riverpod can rebuild a notifier and reassign its dependencies.
- Never mutate state outside a notifier.
- Prefer `AsyncValue.guard` for repository calls.
- Compose providers with `ref.watch(otherProvider)`.

### Routing (auto_route)
- Single `AppRouter` with `@AutoRouterConfig`.
- `AuthGuard` reads `sessionManager.hasCredentials()` and redirects to `LoginRoute` when missing.
- Deep link targets: symbol detail (`/symbol/:market/:symbol`), order detail.

### Error handling
- Use functional style for error handling. Do not use try/catch.
- All API errors normalized into `AppException` (sealed Freezed union):
  `Network | Auth | RateLimit | IpBan | InvalidSignature | ClockSkew | FilterViolation | BinanceApi(code,msg) | Unknown`.
- `error_interceptor.dart` maps Binance error codes:
  - `-1021` → `ClockSkew` (triggers re-sync + one retry)
  - `-1022` → `InvalidSignature` (never silent retry; force re-login)
  - `-2014/-2015` / 401 → `Auth`
  - `-1003` / 429 → `RateLimit`
  - 418 → `IpBan`
  - 5xx → `Network` (retriable)
- Filter violations (tick / lot / minNotional) are caught **before** submission in the trade provider, raised as `FilterViolation` with the offending filter.
- UI surfaces errors via `AsyncValue.error` + a shared `ErrorView` widget.

### Logging (Talker)
- Single `Talker` instance via get_it.
- `RedactingDioLogger` strips `signature`, `X-MBX-APIKEY`, `listenKey`, `apiKey`, `apiSecret` from queries, headers, and bodies **before** anything reaches Talker. No raw secret ever enters the log buffer.
- `talker_dio_logger` is **not** used; its default output leaks signed URLs and headers.

### Time sync
- `SigningInterceptor` lazily syncs with `GET /api/v3/time` on first signed request and stores `serverTime - localTime` offset.
- On `-1021` it invalidates the offset, re-syncs once, and retries the request once. Further failures propagate as `ClockSkew`.

### Environment selection (FR-1.3, EC-11)
- The environment (`mainnet` | `testnet`) is **chosen on the login screen** and persisted alongside the credentials in secure storage under key `binance_env`.
- On launch, `SessionManager.restore()` reads `binance_env` and configures the Dio / WsClient base URLs before the auth guard runs.
- Switching environments **requires logout**. The settings screen exposes this; there is no runtime toggle while logged in.
- `--dart-define=BINANCE_ENV=testnet` remains as a dev override that pre-selects testnet on a cleared install.

### Dio instances
Two Dio instances registered in get_it, both sharing the same interceptor chain and the same `SigningInterceptor` (so the time offset is shared):
- `@Named('spot')` — `api.binance.com` / `testnet.binance.vision`
- `@Named('futures')` — `fapi.binance.com` / `testnet.binancefuture.com`

Repositories inject the one they need.

### Destructive action confirmations (FR-5.4, NFR-10)
A shared `ConfirmationDialog` widget wraps all place/cancel/cancel-all flows. Trade providers only call the repository after the confirmation future resolves true. Logout also routes through it.

---

## 4. Persistence

### Secure storage (`flutter_secure_storage`)
| Key | Value |
|---|---|
| `binance_api_key` | API key |
| `binance_api_secret` | API secret |
| `binance_env` | `mainnet` \| `testnet` |

These keys are read directly by `SigningInterceptor` and `SessionManager`; do not rename without updating them.

### Drift (`app_database.dart`)
Tables (one per entity in parent spec §6):

- `favorites(symbol, market, position)` — PK `(symbol, market)`
- `price_alerts(id, symbol, market, direction, price, enabled, created_at, triggered_at)`
- `cached_portfolio(id=1, fetched_at, balances_json)` — singleton row
- `cached_orders(symbol, market, order_id PK, order_json, fetched_at)` — indexed by `(symbol, market, fetched_at)`
- `cached_symbols(symbol, market, filters_json, updated_at)` — exchangeInfo cache for client-side filter validation
- `settings(key PK, value)` — `theme`, `quote_asset`

Offline reads check `fetched_at` to flag stale data in the UI.

Migrations are versioned in `app_database.dart`; never edit a past migration — add a new one.

### shared_preferences
Only ephemeral UI flags (last selected tab, last viewed symbol). Never credentials. Never anything the parent spec lists as persistent.

### Logout (FR-1.6, EC-15)
`SessionManager.logout()`:
1. Cancels all in-flight Dio requests (via per-request `CancelToken`s held by repositories).
2. Closes all WebSocket subscriptions.
3. Deletes `binance_api_key`, `binance_api_secret`, `binance_env`.
4. Wipes `favorites`, `price_alerts`, `cached_portfolio`, `cached_orders`, `cached_symbols` from Drift.
5. **Keeps** `settings` (theme + quote asset survive).
6. Invalidates all Riverpod providers that hold account data.

---

## 5. Networking

### Dio interceptor order
1. `SigningInterceptor` — signs only for `USER_DATA` / `TRADE` / `USER_STREAM` endpoints
2. `RateLimitInterceptor` — tracks `X-MBX-USED-WEIGHT-*` and `X-MBX-ORDER-COUNT-*` headers, queues if approaching cap, surfaces `RateLimit` at 429
3. `ErrorInterceptor` — maps `DioException` → `AppException`
4. `RedactingDioLogger` — last, with in-process redaction

### WebSocket (`core/ws/ws_client.dart`)
Wraps `WebSocketChannel` with:
- Exponential backoff reconnect (1s → 30s cap) targeting NFR-4 (< 3s typical)
- Heartbeat: server pings every 3 min, client pongs within 10 min
- Combined streams via `/stream?streams=...`
- Separate clients for spot (`stream.binance.com:9443`) and futures (`fstream.binance.com`)
- Per-subscription lifecycle so logout can tear everything down deterministically

### User data stream (`user_data_stream.dart`)
- Obtains `listenKey` via `POST /api/v3/userDataStream` (spot) or `POST /fapi/v1/listenKey` (futures).
- Refreshes every **30 min** (`PUT .../listenKey`).
- On expiry or drop: fetches a new key, reconnects, fills gap via REST `openOrders` + `account`.
- On logout: `DELETE .../listenKey`.

### Order reconciliation (EC-9)
Trade repository wraps every place/cancel call in: send → if response lost / timeout → poll `GET /openOrders` (and `/allOrders` for recently closed) by `clientOrderId` before raising an error. Idempotent by design since every order carries a generated `clientOrderId`.

### Offline / reconnect (FR-9.3)
A single `ConnectivityNotifier` (Riverpod) watches `connectivity_plus`. On recovery it:
1. Triggers refresh on portfolio, orders, markets providers.
2. Asks `WsClient` to resubscribe.
3. Clears any "stale" UI flags.

---

## 6. Code Generation

Run `dart run build_runner build --delete-conflicting-outputs` after changes to:
- Freezed models
- Drift tables
- auto_route definitions
- json_serializable DTOs

`*.g.dart`, `*.freezed.dart`, `*.gr.dart` are committed (so CI doesn't need to codegen).

---

## 7. Testing Strategy

The parent spec (§11) requires integration tests against the **real Binance testnet**, not mocks, for signing and stream logic.

| Layer | Tooling | What to test |
|---|---|---|
| Unit (core) | `flutter_test` + `mocktail` | crypto, interceptors, error mapping, time sync, filter validation |
| Unit (repositories) | `mocktail` `Dio` | request shape, DTO parsing, error translation |
| Provider | `ProviderContainer` | state transitions, refresh, error states |
| Integration | `flutter_test` against **testnet** | login → signed call, kline WS, user data WS, place + cancel |
| Widget | `flutter_test` | login, portfolio, order ticket, confirmation dialog, error views |
| Golden (optional) | `flutter_test` | order ticket, chart overlays |

Conventions:
- File naming: `<source>_test.dart`, mirroring the `lib/` path.
- Unit and widget tests never hit the network. Mock at the `Dio` boundary.
- Integration tests live under `integration_test/` and read testnet keys from `--dart-define=TESTNET_API_KEY=...` etc. Skip with a clear message if absent (so default `flutter test` stays offline).
- Use `ProviderContainer` overrides instead of touching `get_it` directly.
- The signing interceptor test uses `Completer<RequestOptions>` (not `Future.delayed`) to await async signing because of the lazy time sync.

---

## 8. Build & Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs

flutter run                       # default device
flutter run -d macos              # macOS
flutter run --dart-define=BINANCE_ENV=testnet

flutter analyze
flutter test                      # offline unit + widget
flutter test integration_test \   # testnet integration
  --dart-define=TESTNET_API_KEY=... \
  --dart-define=TESTNET_API_SECRET=...
dart format .
dart fix --apply
```

Pre-commit checklist (matches the global Dart rules):
1. `dart format .`
2. `flutter analyze` — zero warnings
3. `flutter test` — green
4. No secrets in diff (grep for `binance_api_secret`)

---

## 9. Implementation Phases

Mapped 1:1 to the parent spec §10 phase table. Each phase ends with: tests green, analyzer clean, manual smoke on at least one mobile and one desktop platform.

| # | Phase | Flutter scope |
|---|---|---|
| 1 | Scaffold + auth + signing + time sync + login | `CredentialsManager`, `SigningInterceptor`, `ErrorInterceptor`, `RateLimitInterceptor`, `RedactingDioLogger`, `AppException`, `AuthRepository.verifyCredentials`, login screen, auth guard, get_it wiring |
| 2 | Env toggle + session persistence + logout | Env picker on login screen, `binance_env` persistence, two Dio instances (spot/futures), `SessionManager.restore()`, logout flow with full wipe |
| 3 | Portfolio view + user data stream | `PortfolioRepository` (spot `/api/v3/account` + futures `/fapi/v2/account`), total value in quote asset, `UserDataStream` (spot + futures), Drift `cached_portfolio` |
| 4 | Markets + favorites + symbol detail WS | `MarketsRepository` (exchangeInfo cache), `FavoritesRepository` (Drift), ticker/depth/trade WS, symbol detail screen scaffold |
| 5 | Spot trading | `SpotTradeRepository` (all order types incl. OCO), order ticket, client-side filter validation, confirmation dialog, open orders, reconcile on lost response |
| 6 | Futures trading | `FuturesTradeRepository` (all order types, reduce-only, post-only, TIF), positions view, leverage display, futures ticket |
| 7 | Charting | `k_chart_plus` wrapper, all required timeframes, MA/EMA/RSI/MACD/BB/Volume, trend/horizontal/rectangle/fib drawings, WS kline updates |
| 8 | Order history + offline cache | `OrderHistoryRepository` (spot + futures), pagination, date filter, Drift `cached_orders`, stale marker UI |
| 9 | Price alerts + notifications | `AlertsRepository` (Drift), evaluator tied to ticker stream, `awesome_notifications` wiring, platform background caveats documented in UI |
| 10 | Transfers (view-only) | `TransfersRepository` (deposit history, withdraw history, addresses). **No withdraw UI anywhere.** |
| 11 | Polish | Theme toggle (manual, no system follow), logging audit, error surfaces, offline state polish, connectivity banner |
| 12 | E2E + NFR validation | `integration_test/` suite against testnet, acceptance checklist §9 of parent spec |

---

## 10. Open Questions (Flutter-specific)

These are *implementation* questions; the product-level open questions live in the parent spec §12.

1. Background isolates for WebSocket on mobile when app is backgrounded — accept disconnect, or use a foreground service on Android? (Impacts FR-7.2 and EC-12.)
2. Biometric unlock (`local_auth`) gating access to the login screen after first run — in or out?
3. Desktop window state persistence (`window_manager`) — now or defer?
4. Crash reporting — Sentry, Firebase Crashlytics, or Talker-only log export?
5. Does `k_chart_plus` cover all drawings required by FR-4.4, or do we need to extend/fork for fib retracement and rectangle?

These do not block Phase 1; revisit before Phase 7 (charting).

---

## 11. Changelog

| Version | Date       | Changes |
|---------|------------|---------|
| 0.2.0   | 2026-04-07 | Realigned to parent spec 0.1.0: futures added, env-at-login with persistence, two Dio instances, filter validation + destructive confirmations, full logout wipe, user data stream (spot + futures), transfers view, offline caching w/ stale markers, manual theme only, phases 1–12 matched to parent, testnet integration tests. |
| 0.1.0   | 2026-04-07 | Initial Flutter implementation spec. |
