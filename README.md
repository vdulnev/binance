# Binance Client

A personal, trader-focused client application for [Binance](https://www.binance.com).

The repository is **platform- and tech-stack-agnostic**: it hosts the shared specification and may contain several concrete implementations targeting different platforms (mobile, desktop, etc.).

## Status

Early development. Phase 1 (login) in progress.

## Scope

Trader-focused features for a single Binance account:

- API Key + API Secret login (mainnet and testnet)
- Persistent session, explicit logout
- Spot and USDⓈ-M futures portfolio and balances
- Spot and futures trading — all supported order types
- Real-time market data via WebSocket (ticker, order book, trades, klines)
- Full technical-analysis charting (indicators, drawing tools, all timeframes)
- Symbol favorites with full-list access
- Order history (spot + futures)
- Local price alerts via device notifications
- Deposit / withdrawal history and addresses (view-only)
- Offline cache for portfolio and history
- Manual light / dark theme

## Explicitly out of scope

Email/password login · multi-account · withdrawal initiation · backend services · margin · options · COIN-M futures · Earn / Launchpad / Staking · P2P · NFTs · copy trading · tax reports · fiat on/off-ramp · convert/swap · multi-language UI

## Authentication

Binance has no email/password or token login. All authenticated requests use:

- `X-MBX-APIKEY` header with the API key
- `timestamp` query parameter (server-time-synced)
- HMAC-SHA256 `signature` of the full query string, computed with the API secret

API keys are created on binance.com and stored in OS-level secure storage. Secrets are never logged or persisted in plaintext.

## Repository layout

- `docs/SPEC.md` — authoritative technical specification. Always read this before implementing a feature.
- `CLAUDE.md` — guidance for Claude Code when working in this repo.
- Implementation directories (per platform) live alongside the docs.

## Error hadling

- log all errors using implementation depended logger

## Working on this project

1. Read `docs/SPEC.md`.
2. Pick a phase from the implementation plan (section 10).
3. Implement against **Binance testnet** (`testnet.binance.vision` for spot, `testnet.binancefuture.com` for futures) first.
4. Verify acceptance criteria (spec section 9) before marking work done.

## License

Personal project. No license granted.
