import 'package:binance_f/core/di/service_locator.dart';
import 'package:binance_f/core/env/env.dart';
import 'package:binance_f/core/env/env_manager.dart';
import 'package:binance_f/features/auth/providers/auth_provider.dart';
import 'package:binance_f/features/auth/providers/auth_state.dart';
import 'package:binance_f/features/auth/widgets/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker/talker.dart';

/// Captures every call to `login` so the test can assert which env was
/// passed in. Replaces the real [AuthNotifier] in the provider override.
class _RecordingAuthNotifier extends Notifier<AuthState>
    implements AuthNotifier {
  final List<({String apiKey, String apiSecret, BinanceEnv env})> calls = [];

  @override
  AuthState build() => const AuthState.unauthenticated();

  @override
  Future<void> login({
    required String apiKey,
    required String apiSecret,
    required BinanceEnv env,
  }) async {
    calls.add((apiKey: apiKey, apiSecret: apiSecret, env: env));
  }

  @override
  Future<void> logout() async {}

  // The test never reaches these — they exist only to satisfy the
  // implements clause. Concrete fields/methods on the real notifier
  // (like `_repository`, `_envManager`, `_stateFromError`) are private
  // so we don't have to mock them.
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUp(() {
    // The login screen reads sl<EnvManager>() to seed its default env, so
    // we have to register a working EnvManager. Use a no-op Dio factory.
    if (sl.isRegistered<EnvManager>()) sl.unregister<EnvManager>();
    if (sl.isRegistered<Talker>()) sl.unregister<Talker>();
    sl.registerSingleton<Talker>(Talker());
    sl.registerSingleton<EnvManager>(
      EnvManager(talker: sl<Talker>(), dioFactory: (_, _) => Dio()),
    );
  });

  tearDown(() {
    sl
      ..unregister<EnvManager>()
      ..unregister<Talker>();
  });

  Future<_RecordingAuthNotifier> pumpLogin(WidgetTester tester) async {
    final fake = _RecordingAuthNotifier();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authProvider.overrideWith(() => fake)],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
    return fake;
  }

  group('LoginScreen env picker', () {
    testWidgets('default selection mirrors EnvManager.current.env', (
      tester,
    ) async {
      // Default fallback (no --dart-define) is mainnet.
      await pumpLogin(tester);

      // Both segments are present.
      expect(find.text('Mainnet'), findsOneWidget);
      expect(find.text('Testnet'), findsOneWidget);

      // SegmentedButton holds the selected set; assert mainnet is in it.
      final segmented = tester.widget<SegmentedButton<BinanceEnv>>(
        find.byType(SegmentedButton<BinanceEnv>),
      );
      expect(segmented.selected, {BinanceEnv.mainnet});
    });

    testWidgets(
      'tapping Testnet then submitting passes BinanceEnv.testnet to login',
      (tester) async {
        final fake = await pumpLogin(tester);

        // Tap testnet segment.
        await tester.tap(find.text('Testnet'));
        await tester.pumpAndSettle();

        // Fill in credentials.
        await tester.enterText(find.byType(TextFormField).at(0), 'my-key');
        await tester.enterText(find.byType(TextFormField).at(1), 'my-secret');

        // Submit.
        await tester.tap(find.widgetWithText(FilledButton, 'Connect'));
        await tester.pumpAndSettle();

        expect(fake.calls, hasLength(1));
        expect(fake.calls.single.apiKey, 'my-key');
        expect(fake.calls.single.apiSecret, 'my-secret');
        expect(fake.calls.single.env, BinanceEnv.testnet);
      },
    );

    testWidgets('submitting on default (mainnet) passes BinanceEnv.mainnet', (
      tester,
    ) async {
      final fake = await pumpLogin(tester);

      await tester.enterText(find.byType(TextFormField).at(0), 'k');
      await tester.enterText(find.byType(TextFormField).at(1), 's');
      await tester.tap(find.widgetWithText(FilledButton, 'Connect'));
      await tester.pumpAndSettle();

      expect(fake.calls, hasLength(1));
      expect(fake.calls.single.env, BinanceEnv.mainnet);
    });

    testWidgets('blank fields → no login call', (tester) async {
      final fake = await pumpLogin(tester);

      await tester.tap(find.widgetWithText(FilledButton, 'Connect'));
      await tester.pumpAndSettle();

      expect(fake.calls, isEmpty);
    });
  });
}
