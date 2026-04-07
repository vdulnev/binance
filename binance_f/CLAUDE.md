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

- Always check docs/SPEC.md before implementing any feature.
