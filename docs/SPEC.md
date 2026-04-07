# Binance Client — Technical Specification

> **Status:** Draft
> **Author:** vd
> **Created:** 2026-04-07
> **Last Updated:** 2026-04-07
> **Version:** 0.1.0

---

## 1. Overview

### 1.1 Problem Statement

A personal, trader-focused client application for Binance (https://www.binance.com). The official Binance apps are general-purpose and carry features the user does not need. This project delivers a focused, fast, trader-oriented client that the user controls end-to-end and can ship to any platform (mobile or desktop). The spec is **platform- and tech-stack-agnostic**: concrete choices (language, framework, storage backend, logging library) are made per implementation.

### 1.2 Goals

- **G1:** Secure API-key-based login with persistent session and full testnet support.
- **G2:** Real-time portfolio view and trading on Binance spot and USDⓈ-M futures.
- **G3:** Full technical-analysis charting with indicators, drawing tools, and multiple timeframes.
- **G4:** Support all Binance order types the user actually trades (market, limit, stop-limit, OCO, trailing, reduce-only, post-only, etc.).
- **G5:** Low-latency market and user data via Binance WebSocket streams.
- **G6:** Local price alerts delivered via device notifications.
- **G7:** Cached data viewable offline; graceful reconnect on network recovery.

### 1.3 Non-Goals

The following are **explicitly out of scope** and must not creep into the implementation:

- Email/password or OAuth login (Binance has no such API).
- Multi-account / multiple API key profiles — single account only.
- Withdrawal or deposit **initiation** (view-only: history + addresses).
- Backend service of any kind (no server, no push notifications, no user accounts).
- Margin trading.
- Options.
- COIN-M futures.
- Binance Earn / Launchpad / Staking.
- P2P trading.
- NFTs.
- Copy trading / social features.
- Tax reports.
- Fiat on-ramp / off-ramp.
- Convert / swap.
- System-follow theming (manual light/dark toggle only).
- Multi-language UI (English only for v1).

---

## 2. User Stories

| ID    | As a...         | I want to...                                                   | So that...                                            | Priority    |
|-------|-----------------|----------------------------------------------------------------|-------------------------------------------------------|-------------|
| US-1  | trader          | log in with my Binance API key + secret                        | the app can access my account securely                | Must-have   |
| US-2  | trader          | toggle between mainnet and testnet                             | I can rehearse strategies without risking real funds  | Must-have   |
| US-3  | trader          | stay logged in across app restarts until I explicitly log out  | I don't re-enter credentials every session            | Must-have   |
| US-4  | trader          | see my spot + futures balances and total portfolio value       | I know my position at a glance                        | Must-have   |
| US-5  | trader          | place and cancel spot orders of any supported type             | I can execute my spot trading strategy                | Must-have   |
| US-6  | trader          | place and cancel USDⓈ-M futures orders of any supported type   | I can execute my futures trading strategy             | Must-have   |
| US-7  | trader          | view real-time candlestick charts with indicators and drawings | I can make TA-driven decisions inside the app         | Must-have   |
| US-8  | trader          | keep a favorites list of symbols with access to the full list  | I reach the pairs I care about instantly              | Must-have   |
| US-9  | trader          | see live order book, trades, and my open orders                | I can react to the market in real time                | Must-have   |
| US-10 | trader          | view order history for spot and futures                        | I can review past executions                          | Must-have   |
| US-11 | trader          | set local price alerts                                         | I'm notified when price crosses a level               | Should-have |
| US-12 | trader          | view deposit/withdrawal history and deposit addresses          | I can track funding movements                         | Should-have |
| US-13 | trader          | browse cached portfolio and history offline                    | I can check state without a connection                | Should-have |
| US-14 | trader          | switch between light and dark themes manually                  | I can match my environment                            | Should-have |
| US-15 | trader          | log out and wipe stored credentials                            | I can safely hand off or decommission a device        | Must-have   |

---

## 3. Functional Requirements

### 3.1 Authentication & Session

- **FR-1.1:** The system shall accept a Binance API key and API secret as the sole credentials.
- **FR-1.2:** The system shall verify credentials by issuing a signed `GET /api/v3/account` request before accepting a login.
- **FR-1.3:** The system shall support switching between mainnet (`api.binance.com`) and testnet (`testnet.binance.vision` for spot, `testnet.binancefuture.com` for futures) at login time. The selected environment shall be stored with the credentials.
- **FR-1.4:** The system shall persist credentials in OS-level secure storage. Plaintext storage or logging of secrets is forbidden.
- **FR-1.5:** The session shall remain active indefinitely until the user triggers an explicit logout.
- **FR-1.6:** Logout shall delete all stored credentials and cached user data tied to the account.
- **FR-1.7:** The system shall detect and surface auth errors: invalid signature, invalid API key, insufficient permissions, rate limiting (HTTP 429), IP ban (HTTP 418), and clock skew (`-1021`).
- **FR-1.8:** The system shall synchronize local time with Binance server time (`GET /api/v3/time`) and adjust the `timestamp` parameter to avoid `-1021` errors.

### 3.2 Portfolio & Balances

- **FR-2.1:** The system shall display spot balances (free, locked) and USDⓈ-M futures balances (wallet, unrealized PnL, margin).
- **FR-2.2:** The system shall display total portfolio value in a user-selected quote asset (default USDT).
- **FR-2.3:** Portfolio data shall update in real time via the user data WebSocket stream (listen key).
- **FR-2.4:** The system shall cache the last-known portfolio snapshot for offline viewing.

### 3.3 Market Data & Favorites

- **FR-3.1:** The system shall let the user maintain a favorites list of trading symbols, and shall also provide access to the full list of Binance spot and USDⓈ-M futures symbols.
- **FR-3.2:** The system shall display real-time ticker, order book, and recent trades for the selected symbol via WebSocket streams.
- **FR-3.3:** The system shall fall back to REST polling only if the WebSocket connection is unrecoverable, and shall surface the degraded state to the user.

### 3.4 Charting

- **FR-4.1:** The system shall render candlestick charts for any supported symbol.
- **FR-4.2:** The system shall support standard Binance kline timeframes (1m, 3m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 8h, 12h, 1d, 3d, 1w, 1M).
- **FR-4.3:** The system shall support common technical indicators (at minimum: MA, EMA, RSI, MACD, Bollinger Bands, Volume).
- **FR-4.4:** The system shall support basic drawing tools (at minimum: trend line, horizontal line, rectangle, Fibonacci retracement).
- **FR-4.5:** The system shall stream live kline updates via WebSocket.

### 3.5 Trading (Spot & Futures)

- **FR-5.1:** The system shall support placing and canceling orders of all types exposed by the Binance spot and USDⓈ-M futures APIs, including: MARKET, LIMIT, STOP_LOSS, STOP_LOSS_LIMIT, TAKE_PROFIT, TAKE_PROFIT_LIMIT, LIMIT_MAKER, OCO, TRAILING_STOP_MARKET, and futures-specific flags (reduce-only, post-only, time-in-force: GTC/IOC/FOK/GTX).
- **FR-5.2:** The system shall show open orders and position state in real time via the user data stream.
- **FR-5.3:** The system shall validate order parameters client-side against the symbol's exchange filters (tick size, lot size, min notional) before submission.
- **FR-5.4:** The system shall require an explicit confirmation step before submitting any destructive action (place order, cancel order, cancel all).
- **FR-5.5:** The system shall display an order receipt (status, fills, fees) on response.

### 3.6 Order History

- **FR-6.1:** The system shall display historical orders and trades for spot and futures, with pagination and date filtering.
- **FR-6.2:** The system shall cache history for offline viewing.

### 3.7 Price Alerts

- **FR-7.1:** The user shall be able to create, edit, and delete local price alerts for any symbol (threshold: price crosses above/below a value).
- **FR-7.2:** Alerts shall be stored locally and evaluated against the live ticker stream while the app is running or backgrounded (subject to platform constraints).
- **FR-7.3:** Alert delivery shall use local device notifications only. No backend push.

### 3.8 Deposits & Withdrawals (View-Only)

- **FR-8.1:** The system shall display deposit history, withdrawal history, and per-asset deposit addresses.
- **FR-8.2:** The system shall **not** provide any UI for initiating a withdrawal.

### 3.9 Offline & Caching

- **FR-9.1:** The system shall cache portfolio snapshots, order history, favorites, and last-viewed market data.
- **FR-9.2:** Cached data shall be viewable without a network connection; the UI shall clearly mark data as stale.
- **FR-9.3:** On reconnect, the system shall automatically refresh cached views and resubscribe to WebSocket streams.

### 3.10 Theming & UI

- **FR-10.1:** The system shall provide a manual light/dark theme toggle. It shall not follow system theme.
- **FR-10.2:** The UI language shall be English.

### 3.11 Logging

- **FR-11.1:** The system shall emit extensive structured logs using a logging facility appropriate to the chosen tech stack.
- **FR-11.2:** Logs shall never contain API secrets, signatures, listen keys, or full API keys. Sensitive values shall be redacted.

---

## 4. Non-Functional Requirements

| ID    | Category         | Requirement                                               | Target                                         |
|-------|------------------|-----------------------------------------------------------|------------------------------------------------|
| NFR-1 | Performance      | Order submission round-trip (local overhead only)         | < 100ms excluding network                      |
| NFR-2 | Performance      | Chart rendering frame rate                                | 60 fps on target hardware                      |
| NFR-3 | Performance      | Cold start to usable UI                                   | < 2s on target hardware                        |
| NFR-4 | Performance      | WebSocket reconnect after drop                            | < 3s automatic retry with backoff              |
| NFR-5 | Reliability      | Graceful handling of Binance rate limits / bans           | Backoff + user-visible state, no crash         |
| NFR-6 | Security         | Credential storage                                        | OS secure storage; never plaintext or logged   |
| NFR-7 | Security         | Request signing                                           | HMAC-SHA256 over full query string             |
| NFR-8 | Compatibility    | Target platforms                                          | Any mobile or desktop (per implementation)     |
| NFR-9 | Observability    | Logging                                                   | Extensive, structured, secret-redacted         |
| NFR-10| Usability        | Destructive trading actions                               | Require explicit confirmation                  |
| NFR-11| Offline          | Cached data accessible without network                    | Portfolio, history, favorites, last market    |

---

## 5. Architecture & Technical Design

### 5.1 System Overview

The application is a standalone client with no backend. It talks directly to Binance REST and WebSocket endpoints.

```
[Client App]
   ├── REST client ────────────► api.binance.com
   │                             testnet.binance.vision
   │                             fapi.binance.com
   │                             testnet.binancefuture.com
   ├── WebSocket client ───────► stream.binance.com
   │                             fstream.binance.com
   ├── Secure credential store (OS-level)
   └── Local cache (portfolio, history, favorites, alerts)
```

### 5.2 Tech Stack

**Deferred to per-implementation.** Each concrete implementation (e.g. Flutter mobile, desktop native, web) chooses its own:

- Language / framework
- State management
- HTTP and WebSocket clients
- Secure credential storage mechanism
- Charting library (must support candles, indicators, drawings)
- Logging library
- Local persistence (SQLite, key-value, file — implementer's call)

Each implementation must satisfy every requirement in sections 3 and 4 and conform to section 7.

### 5.3 Key Design Decisions

| Decision                  | Choice                          | Alternatives Considered                 | Rationale                                                           |
|---------------------------|---------------------------------|-----------------------------------------|---------------------------------------------------------------------|
| Authentication            | API Key + HMAC-SHA256 signature | (none — Binance has no other option)    | Only supported Binance auth model                                   |
| Accounts                  | Single active account           | Multi-account profile switching         | Personal tool; simpler security surface                             |
| Backend                   | None                            | Thin backend for push/alerts            | No infra cost; local notifications suffice                          |
| Real-time transport       | WebSocket streams               | REST polling                            | Required for low-latency trading UX                                 |
| Environment toggle        | Mainnet ↔ testnet at login      | Separate builds                         | One build, rehearsable strategies                                   |
| Withdrawals               | View-only                       | Full initiate                           | Eliminates withdrawal-permission attack surface                     |
| Theming                   | Manual light/dark               | Follow system                           | User preference                                                     |
| Tech stack                | Deferred per implementation     | Locked framework                        | Spec must cover any platform                                        |
| Credential storage impl.  | Deferred per implementation     | Locked library                          | Depends on chosen stack                                             |

---

## 6. Data Model

All persisted locally on the device. No server-side model.

### 6.1 Entities

#### Credentials (exactly one record)

| Field        | Type     | Constraints                    | Description                             |
|--------------|----------|--------------------------------|-----------------------------------------|
| api_key      | string   | required, secure storage       | Binance API key                         |
| api_secret   | string   | required, secure storage       | Binance API secret                      |
| environment  | enum     | {mainnet, testnet}             | Selected environment                    |
| created_at   | datetime | auto-set                       | When credentials were saved             |

#### Favorite

| Field     | Type   | Constraints              | Description                  |
|-----------|--------|--------------------------|------------------------------|
| symbol    | string | PK                       | e.g. `BTCUSDT`               |
| market    | enum   | {spot, futures}          | Which market the symbol is on|
| position  | int    | required                 | Sort order                   |

#### PriceAlert

| Field      | Type    | Constraints                | Description                         |
|------------|---------|----------------------------|-------------------------------------|
| id         | uuid    | PK                         | Local id                            |
| symbol     | string  | required                   | Target symbol                       |
| market     | enum    | {spot, futures}            | Market                              |
| direction  | enum    | {above, below}             | Crossing direction                  |
| price      | decimal | required                   | Threshold price                     |
| enabled    | bool    | default true               | Active flag                         |
| created_at | datetime| auto-set                   | When alert was created              |
| triggered_at| datetime| nullable                  | Last trigger time                   |

#### CachedPortfolioSnapshot

| Field        | Type     | Constraints        | Description                               |
|--------------|----------|--------------------|-------------------------------------------|
| fetched_at   | datetime | auto-set           | Last refresh                              |
| balances_json| blob     | required           | Serialized balance / position state       |

#### CachedOrderHistory

| Field        | Type     | Constraints        | Description                               |
|--------------|----------|--------------------|-------------------------------------------|
| symbol       | string   | indexed            | Symbol                                    |
| market       | enum     | {spot, futures}    | Market                                    |
| order_json   | blob     | required           | Serialized historical order               |
| fetched_at   | datetime | auto-set           | Cache timestamp                           |

#### Settings (singleton)

| Field        | Type     | Constraints                | Description                 |
|--------------|----------|----------------------------|-----------------------------|
| theme        | enum     | {light, dark}              | Manual theme selection      |
| quote_asset  | string   | default `USDT`             | Portfolio valuation quote   |

### 6.2 Relationships

- `PriceAlert` many → one `symbol` (logical, by string).
- `Favorite` many → one `symbol`.
- All entities are scoped to the single logged-in account; logout deletes everything except `Settings`.

---

## 7. API / Interface Contract

The client consumes the public Binance API. It exposes no API of its own.

### 7.1 Binance Endpoints Used

| Area            | Endpoint                                        | Security      | Purpose                           |
|-----------------|-------------------------------------------------|---------------|-----------------------------------|
| Time sync       | `GET /api/v3/time`                              | NONE          | Clock skew correction             |
| Exchange info   | `GET /api/v3/exchangeInfo`                      | NONE          | Symbols, filters, tick/lot sizes  |
| Futures info    | `GET /fapi/v1/exchangeInfo`                     | NONE          | Futures symbols and filters       |
| Account         | `GET /api/v3/account`                           | USER_DATA     | Spot balances, login verification |
| Futures account | `GET /fapi/v2/account`                          | USER_DATA     | Futures balances, positions       |
| Place order     | `POST /api/v3/order`                            | TRADE         | Spot order                        |
| OCO order       | `POST /api/v3/order/oco`                        | TRADE         | Spot OCO                          |
| Cancel order    | `DELETE /api/v3/order`                          | TRADE         | Spot cancel                       |
| Open orders     | `GET /api/v3/openOrders`                        | USER_DATA     | Spot open orders                  |
| Order history   | `GET /api/v3/allOrders`                         | USER_DATA     | Spot history                      |
| Futures order   | `POST /fapi/v1/order`                           | TRADE         | Futures order                     |
| Futures cancel  | `DELETE /fapi/v1/order`                         | TRADE         | Futures cancel                    |
| Futures history | `GET /fapi/v1/allOrders`                        | USER_DATA     | Futures history                   |
| Klines          | `GET /api/v3/klines` / `/fapi/v1/klines`        | NONE          | Chart candles                     |
| Deposit history | `GET /sapi/v1/capital/deposit/hisrec`           | USER_DATA     | Deposits view                     |
| Withdraw hist.  | `GET /sapi/v1/capital/withdraw/history`         | USER_DATA     | Withdrawals view                  |
| Deposit address | `GET /sapi/v1/capital/deposit/address`          | USER_DATA     | Deposit addresses                 |
| Listen key      | `POST /api/v3/userDataStream`                   | USER_STREAM   | Spot user data stream key         |
| Futures key     | `POST /fapi/v1/listenKey`                       | USER_STREAM   | Futures user data stream key      |

### 7.2 Request Signing

1. Attach `X-MBX-APIKEY` header with the API key.
2. Append `timestamp=<ms since epoch, server-synced>` to the query string.
3. Optionally append `recvWindow=<ms>` (default 5000).
4. Compute HMAC-SHA256 of the full query string using the API secret.
5. Append `signature=<hex>` to the query string.

### 7.3 WebSocket Streams Used

| Stream                          | Purpose                                   |
|---------------------------------|-------------------------------------------|
| `<symbol>@kline_<interval>`     | Live candles                              |
| `<symbol>@depth`                | Order book                                |
| `<symbol>@trade`                | Recent trades                             |
| `<symbol>@ticker`               | 24h ticker                                |
| User data stream (listen key)   | Account updates, orders, positions, fills |

### 7.4 Error Surface

| HTTP / Binance code | Meaning                        | App behavior                                  |
|---------------------|--------------------------------|-----------------------------------------------|
| 401 / -2014, -2015  | Bad API key / permission       | Prompt re-login                               |
| -1021               | Timestamp outside recvWindow   | Re-sync time, retry once                      |
| -1022               | Invalid signature              | Prompt re-login, never silent retry           |
| 429                 | Rate limited                   | Backoff, user-visible state                   |
| 418                 | IP banned                      | Hard-stop, surface remaining ban time         |
| 5xx                 | Binance outage                 | Retry with backoff, show degraded state       |

---

## 8. Edge Cases & Error Handling

| ID    | Scenario                                            | Expected Behavior                                                              |
|-------|-----------------------------------------------------|--------------------------------------------------------------------------------|
| EC-1  | Invalid API key / secret at login                   | Show clear error; no credentials saved                                         |
| EC-2  | API key lacks trade permission                      | Login succeeds read-only; trading UI disables with explanation                 |
| EC-3  | Device clock skew > recvWindow                      | Auto-resync via `/api/v3/time`; retry once; then surface error                |
| EC-4  | Rate limit (429) during burst                       | Exponential backoff; pause non-critical polling; show banner                   |
| EC-5  | IP ban (418)                                        | Hard-stop requests; show ban state; no retries                                 |
| EC-6  | WebSocket drops                                     | Auto-reconnect with backoff; resubscribe; fill gap via REST                    |
| EC-7  | Listen key expires                                  | Refresh listen key every 30 min; on expiry reconnect user data stream          |
| EC-8  | Order validation fails exchange filters             | Reject client-side before submit with specific message                        |
| EC-9  | Order submitted but response lost                   | Reconcile via open-orders query before assuming failure                        |
| EC-10 | Network offline                                     | Serve cached data, mark as stale, disable trading                              |
| EC-11 | Testnet ↔ mainnet environment mismatch              | Require logout before switching environment                                    |
| EC-12 | Alert fires while app suspended                     | Best-effort via local notification subject to platform background policy      |
| EC-13 | Symbol delisted while favorited                     | Mark favorite as unavailable; allow removal                                    |
| EC-14 | Credentials missing from secure storage on launch   | Route to login screen                                                          |
| EC-15 | Logout mid-request                                  | Cancel in-flight requests and wipe credentials + caches                        |

---

## 9. Acceptance Criteria

| ID    | Linked To | Criterion                                                                                 | Verified |
|-------|-----------|-------------------------------------------------------------------------------------------|----------|
| AC-1  | US-1      | User enters API key + secret and is logged in only if `/api/v3/account` succeeds          | [ ]      |
| AC-2  | US-2      | User can pick mainnet or testnet at login; selection is honored by all requests          | [ ]      |
| AC-3  | US-3      | Killing and reopening the app preserves the session without re-entering credentials      | [ ]      |
| AC-4  | US-4      | Portfolio view shows spot + futures balances and total value in the chosen quote asset   | [ ]      |
| AC-5  | US-4      | Balances update live via user data stream without manual refresh                          | [ ]      |
| AC-6  | US-5      | User can place and cancel all supported spot order types and sees them in open orders     | [ ]      |
| AC-7  | US-6      | User can place and cancel all supported futures order types including reduce-only         | [ ]      |
| AC-8  | US-7      | Charts render candles on all supported timeframes with at least the required indicators   | [ ]      |
| AC-9  | US-7      | User can add, move, and delete chart drawings                                              | [ ]      |
| AC-10 | US-8      | Favorites list is user-editable and the full symbol list is reachable                      | [ ]      |
| AC-11 | US-9      | Order book, trades, and open orders update in real time                                   | [ ]      |
| AC-12 | US-10     | Spot and futures order history pages with date filtering work online and offline (cached) | [ ]      |
| AC-13 | US-11     | Price alerts fire via local notifications when thresholds cross                            | [ ]      |
| AC-14 | US-12     | Deposit/withdrawal history and deposit addresses are viewable; no withdrawal UI exists    | [ ]      |
| AC-15 | US-13     | With the network disabled, cached portfolio and history remain viewable and marked stale | [ ]      |
| AC-16 | US-14     | Theme toggle switches between light and dark immediately                                   | [ ]      |
| AC-17 | US-15     | Logout removes stored credentials and cached account data from the device                 | [ ]      |
| AC-18 | NFR-6     | Audit of storage and logs shows no plaintext API secret or signature anywhere              | [ ]      |
| AC-19 | NFR-5     | Under simulated 429 / 418, app backs off and stays responsive without crash                | [ ]      |
| AC-20 | FR-5.4    | Every destructive action shows a confirmation step                                         | [ ]      |

---

## 10. Implementation Plan

Phases map to the user's priority order: **portfolio → spot → futures → charts → history → alerts → transfers**.

| Phase | Task                                                                 | Depends On | Est. Effort | Status      |
|-------|----------------------------------------------------------------------|------------|-------------|-------------|
| 1     | Project scaffold, secure storage, HTTP + signing, time sync, login   | —          | M           | Not started |
| 2     | Environment toggle (mainnet/testnet), session persistence, logout    | 1          | S           | Not started |
| 3     | Portfolio view (spot + futures balances, total value) + user stream  | 2          | M           | Not started |
| 4     | Market list, favorites, ticker + order book + trades WS              | 2          | M           | Not started |
| 5     | Spot trading (all order types) + open orders + confirmations         | 3, 4       | L           | Not started |
| 6     | Futures trading (all order types, reduce-only, positions)            | 5          | L           | Not started |
| 7     | Charting (candles, timeframes, indicators, drawings, live klines)    | 4          | L           | Not started |
| 8     | Order history (spot + futures) with caching + offline view           | 5, 6       | M           | Not started |
| 9     | Price alerts + local notifications                                   | 4          | M           | Not started |
| 10    | Deposits/withdrawals view + addresses                                | 2          | S           | Not started |
| 11    | Theme toggle, logging, error surfaces, offline polish                | all        | S           | Not started |
| 12    | End-to-end testing vs testnet, NFR validation, acceptance checklist  | all        | M           | Not started |

> **Effort scale:** S = hours, M = 1–2 days, L = 3–5 days, XL = 1+ week

---

## 11. Testing Strategy

| Type              | Scope                                                        | Approach                                                             |
|-------------------|--------------------------------------------------------------|----------------------------------------------------------------------|
| Unit tests        | Request signer, time sync, filter validation, alert engine  | Per-stack unit framework                                             |
| Integration tests | REST + WebSocket flows against **Binance testnet**           | Real testnet credentials; never mocks for signing or stream logic    |
| E2E tests         | Login → portfolio → place order → cancel → history          | Automated against testnet                                            |
| Manual QA         | Charts interaction, alert delivery, offline mode, theme     | Checklist-based per platform build                                   |
| Security review   | Credential storage, log redaction, no-withdraw UI           | Static + manual audit before every release                          |

---

## 12. Open Questions

| #  | Question                                                                     | Owner | Status | Resolution |
|----|------------------------------------------------------------------------------|-------|--------|------------|
| 1  | Required chart indicator and drawing set beyond the baseline in FR-4.3/4.4?  | vd    | Open   |            |
| 2  | Quote asset options for total portfolio value (USDT, BTC, USD)?              | vd    | Open   |            |
| 3  | Retention policy for cached history (size/age cap)?                          | vd    | Open   |            |
| 4  | Behavior when API key is read-only: hide trading UI or show disabled?        | vd    | Open   |            |
| 5  | Do we treat spot and futures balances as one total or two separate views?    | vd    | Open   |            |

---

## 13. Changelog

| Version | Date       | Author | Changes                                                          |
|---------|------------|--------|------------------------------------------------------------------|
| 0.1.0   | 2026-04-07 | vd     | Initial draft from interview: scope, auth, trading, charts, WS   |
