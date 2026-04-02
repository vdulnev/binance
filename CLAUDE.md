# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Client application for Binance (https://www.binance.com). The repository may contain several different implementations/platforms.

## Phases

### Phase 1 — Login Flow
- Email/password authentication against Binance API
- 2FA support (Google Authenticator, SMS)
- Secure token storage (access token + refresh token)
- Session persistence (stay logged in across app restarts)
- Login error handling (invalid credentials, rate limiting, account locked)
- Logout with token revocation

## API

- Base URL: `https://api.binance.com`
- Auth endpoints use API key + HMAC-SHA256 signed requests
- All sensitive data (API keys, tokens) must be stored securely — never in plain text or logs
