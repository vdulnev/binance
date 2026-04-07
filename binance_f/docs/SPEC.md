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
| Logging | **Talker** + `talker_dio_logger` + `talker_flutter` | redact secrets in interceptor |
| Models / unions | **Freezed** + `json_serializable` | sealed classes for state + DTOs |
| HTTP | **Dio** | with custom interceptors |
| WebSocket | **web_socket_channel** | Dio is HTTP-only |
| Secure storage | **flutter_secure_storage** | Keychain on Apple, Keystore on Android |
| Local DB | **drift** (SQLite) | watchlists, cached symbols, settings |
| Simple prefs | **shared_preferences** | non-sensitive flags only |
| Charting | **k_chart_plus** | candlestick + indicators |
| Notifications | **awesome_notifications** | local order/price alerts |
| Mocking (tests) | **mocktail** | per project test convention |

### Target platforms

iOS, Android, macOS, Windows, Linux. Web is **not** a target (secure storage + WebSocket constraints).

Per-platform notes:
- **macOS**: Keychain entitlement required in both `DebugProfile.entitlements` and `Release.entitlements` (`com.apple.security.keychain-access-groups` → `$(AppIdentifierPrefix)com.example.binancef`).
- **Windows/Linux**: `flutter_secure_storage` falls back to libsecret / DPAPI; verify on first run.
- **Android**: `minSdk` must satisfy `flutter_secure_storage` (≥ 23 for AES).

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
│   │   ├── dio_client.dart
│   │   ├── signing_interceptor.dart
│   │   ├── rate_limit_interceptor.dart
│   │   └── error_interceptor.dart
│   ├── auth/
│   │   ├── credentials_manager.dart
│   │   └── session_manager.dart
│   ├── security/
│   │   ├── secure_storage_service.dart
│   │   └── crypto_utils.dart
│   ├── ws/
│   │   ├── ws_client.dart         # reconnect, backoff, ping
│   │   └── user_data_stream.dart  # listenKey lifecycle
│   ├── db/
│   │   ├── app_database.dart      # drift
│   │   └── tables/
│   ├── logging/talker.dart
│   ├── routing/
│   │   ├── app_router.dart        # @AutoRouterConfig
│   │   └── auth_guard.dart
│   ├── env/env.dart               # mainnet vs testnet base URLs
│   └── theme/app_theme.dart
└── features/
    ├── auth/        {data,providers,widgets}
    ├── account/     {data,providers,widgets}
    ├── markets/     {data,providers,widgets}
    ├── symbol/      {data,providers,widgets}   # detail + chart
    ├── orderbook/   {data,providers,widgets}
    ├── trade/       {data,providers,widgets}   # place / cancel orders
    ├── orders/      {data,providers,widgets}   # open + history
    ├── watchlist/   {data,providers,widgets}
    ├── alerts/      {data,providers,widgets}
    └── settings/    {data,providers,widgets}
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
- One provider per concern; compose with `ref.watch(otherProvider)`.

### Routing (auto_route)
- Single `AppRouter` with `@AutoRouterConfig`.
- `AuthGuard` reads `sessionManager.hasCredentials()` and redirects to `LoginRoute` when missing.
- Deep link targets: symbol detail (`/symbol/:symbol`), order detail.

### Error handling
- All API errors normalized into `AppException` (sealed Freezed union):
  `Network | Auth | RateLimit | InvalidSignature | ClockSkew | BinanceApi(code,msg) | Unknown`.
- `error_interceptor.dart` maps Binance error codes:
  - `-1021` → `ClockSkew` (triggers re-sync)
  - `-1022` → `InvalidSignature`
  - `-2014/-2015` → `Auth`
  - `-1003/418/429` → `RateLimit`
- UI surfaces errors via `AsyncValue.error` + a shared `ErrorView` widget.

### Logging (Talker)
- Single `Talker` instance via get_it.
- `talker_dio_logger` attached to Dio.
- **Redaction**: `SigningInterceptor` strips `signature`, `X-MBX-APIKEY`, and any `apiKey/apiSecret` field from logged requests/responses. Never log the secret, even in debug.

### Time sync
- `SigningInterceptor` lazily syncs with `GET /api/v3/time` on first signed request and stores `serverTime - localTime` offset.
- On `-1021` response, the interceptor invalidates the offset and retries once.

### Environment
- `core/env/env.dart` exposes `Env.mainnet` and `Env.testnet`. Default to mainnet; testnet selectable in dev builds via a `--dart-define=BINANCE_ENV=testnet`.
- Base URLs:
  - Mainnet REST: `https://api.binance.com`
  - Mainnet WS: `wss://stream.binance.com:9443`
  - Testnet REST: `https://testnet.binance.vision`

---

## 4. Persistence

### Secure storage (`flutter_secure_storage`)
| Key | Value |
|---|---|
| `binance_api_key` | API key |
| `binance_api_secret` | API secret |

These keys are read directly by `SigningInterceptor`; do not rename without updating it.

### Drift (`app_database.dart`)
Tables:
- `watchlist_symbols(symbol PK, added_at)`
- `cached_symbols(symbol PK, base, quote, status, filters_json, updated_at)` — exchangeInfo cache
- `price_alerts(id PK, symbol, op, threshold, enabled, created_at)`
- `settings(key PK, value)` — non-sensitive UI prefs that need transactional writes

Migrations are versioned in `app_database.dart`; never edit a past migration — add a new one.

### shared_preferences
Only ephemeral UI flags (last selected tab, theme mode). Never credentials.

---

## 5. Networking

### Dio interceptor order
1. `SigningInterceptor` — signs only when endpoint is in the signed allow-list (or always for `USER_DATA`/`TRADE` paths)
2. `RateLimitInterceptor` — tracks `X-MBX-USED-WEIGHT-*` headers, queues if approaching cap
3. `ErrorInterceptor` — maps to `AppException`
4. `TalkerDioLogger` — last, with redaction

### WebSocket (`core/ws/ws_client.dart`)
- Wraps `WebSocketChannel` with:
  - Exponential backoff reconnect (1s → 30s cap)
  - Heartbeat / ping handling per Binance docs (server pings every 3 min, client must pong within 10 min)
  - Stream multiplexing via combined streams `/stream?streams=...`
- `UserDataStream`: obtains `listenKey` via `POST /api/v3/userDataStream`, refreshes every 30 min, deletes on logout.

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

| Layer | Tooling | What to test |
|---|---|---|
| Unit (core) | `flutter_test` + `mocktail` | crypto, interceptors, error mapping, time sync |
| Unit (repositories) | `mocktail` `Dio` | request shape, DTO parsing, error translation |
| Provider | `ProviderContainer` | state transitions, refresh, error states |
| Widget | `flutter_test` | login, home, order ticket, error views |
| Golden | `flutter_test` (optional) | trade ticket layout |

Conventions:
- File naming: `<source>_test.dart`, mirroring the `lib/` path.
- Never hit the network in tests. Mock at the `Dio` boundary.
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
flutter test
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

Mapped to the parent spec phases.

1. **Auth & session** *(in progress)*
   - `CredentialsManager`, `SessionManager`, `SigningInterceptor` (with time sync), `AuthRepository.verifyCredentials()`, login screen, auth guard.
2. **Account overview**
   - `AccountRepository`, `accountProvider`, home screen with balances, commissions, permissions.
3. **Markets & symbol detail**
   - exchangeInfo cache (Drift), 24h ticker list, symbol detail with `k_chart_plus` candles, klines REST + WS update.
4. **Order book & trades stream**
   - WS depth stream, local order book maintenance, recent trades.
5. **Trading**
   - Order ticket (limit / market), open orders list, cancel, order history, user data stream for live updates.
6. **Watchlist & alerts**
   - Drift-backed watchlist, price alerts via `awesome_notifications` triggered from a foreground stream subscription.
7. **Settings**
   - Theme, env switch (dev only), logout, about.

Each phase ends with: tests green, analyzer clean, manual smoke on at least one mobile and one desktop platform.

---

## 10. Open Questions (Flutter-specific)

1. Background isolates for WebSocket on mobile when app is backgrounded — accept disconnect, or use a foreground service on Android?
2. Biometric unlock (`local_auth`) before exposing API secret screen — in or out of Phase 1?
3. Multi-account support — does `CredentialsManager` need a profile dimension, or stay single-account for v1?
4. Desktop window state persistence — `window_manager` package, or skip for v1?
5. Crash reporting — Sentry, Firebase Crashlytics, or Talker-only?

These do not block Phase 1; revisit before Phase 5.

---

## 11. Changelog

- 2026-04-07 — Initial Flutter implementation spec derived from parent `docs/SPEC.md`.
