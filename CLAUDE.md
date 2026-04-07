# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

- Always check docs/SPEC.md before implementing any feature.

## Project

Client application for Binance (https://www.binance.com). The repository may contain several different implementations/platforms.

## Phases

### Phase 1 — Login Flow
- API Key + API Secret authentication (Binance has no email/password login API)
- Credential verification via signed `GET /api/v3/account` call
- Secure credential storage (API key + API secret)
- Session persistence (stay logged in across app restarts)
- Login error handling (invalid signature, rate limiting, IP ban, clock sync)
- Logout by clearing stored credentials

## API

- Base URL: `https://api.binance.com`
- Binance has **no email/password or token-based login** — all auth is API Key + HMAC-SHA256 signed requests
- Users create API keys on binance.com (2FA is handled there, not via the API)
- All sensitive data (API keys, secrets) must be stored securely — never in plain text or logs

### Request signing

1. `X-MBX-APIKEY` header carries the API key
2. `timestamp` query parameter (milliseconds since epoch) is added to every signed request
3. HMAC-SHA256 signature is computed over the full query string using the API secret
4. `signature` query parameter is appended to the request
5. `recvWindow` (optional, default 5000ms) controls request validity window

### Endpoint security types

| Type | Auth required |
|------|--------------|
| NONE | No auth (public market data) |
| TRADE | API key + signature |
| USER_DATA | API key + signature |
| USER_STREAM | API key only |
