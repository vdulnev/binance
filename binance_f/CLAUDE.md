# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter client for Binance. Dart SDK ≥3.11.1, uses Material Design.

## Commands

```bash
# Run
flutter run                        # launch on connected device/emulator
flutter run -d chrome              # launch in Chrome (web)

# Build
flutter build apk                  # Android APK
flutter build ios                  # iOS (requires macOS + Xcode)

# Lint & format
flutter analyze                    # static analysis (uses flutter_lints)
dart format .                      # format all Dart files
dart fix --apply                   # auto-fix lint issues

# Test
flutter test                       # run all tests
flutter test test/path/to_test.dart  # run a single test file
```

## Architecture

Feature-first structure under `lib/features/<feature>/`. Each feature contains its own widgets, models, and logic. Business logic stays out of widgets.

## Libraries

Use Riverprod for state management.
Use Freezed for models.
User Talker for logging.
Use auto_route for navigation.
Use get_it for service location.

Entry point: `lib/main.dart` → `MainApp` widget.

## API Integration

- Base URL: `https://api.binance.com`
- Auth: API key + HMAC-SHA256 signed requests
- Store secrets securely (e.g., flutter_secure_storage) — never in plain text or logs

## Authentication

Binance has **no email/password login API**. Authentication uses API Key + API Secret credentials that users create on binance.com (2FA is handled there, not via the API).

### How it works

1. User enters API Key and API Secret on the login screen
2. Credentials are stored in `flutter_secure_storage` under keys `binance_api_key` and `binance_api_secret`
3. `CredentialsManager` manages storage; `SessionManager` checks if credentials exist
4. Credentials are verified by calling `GET /api/v3/account` (a signed USER_DATA endpoint)
5. `SigningInterceptor` automatically reads stored credentials and signs every request:
   - Adds `X-MBX-APIKEY` header
   - Adds `timestamp` query parameter (milliseconds)
   - Computes HMAC-SHA256 signature over the query string and appends it
6. Logout simply clears stored credentials

### Key files

- `lib/core/auth/credentials_manager.dart` — stores/retrieves API key and secret
- `lib/core/auth/session_manager.dart` — checks if credentials exist (session validity)
- `lib/core/api/signing_interceptor.dart` — signs requests with HMAC-SHA256
- `lib/features/auth/data/auth_repository.dart` — verifies credentials via account endpoint
- `lib/features/auth/providers/auth_provider.dart` — Riverpod notifier for auth state
