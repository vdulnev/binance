import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'app.dart';
import 'core/auth/session_manager.dart';
import 'core/di/service_locator.dart';
import 'features/alerts/data/alert_evaluator.dart';
import 'features/alerts/data/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise local notifications before DI so the channel exists when
  // the evaluator fires its first alert (Phase 9 — FR-7.3).
  await NotificationService.initialize();
  await NotificationService.requestPermissionIfNeeded();

  await initServiceLocator();

  // Restore the persisted env BEFORE the router mounts so the auth guard's
  // first signed call hits the right Binance host. This must run after DI
  // (so EnvManager + CredentialsManager exist) and before runApp (so the
  // root MaterialApp.router doesn't construct the AuthGuard against a
  // stale Dio).
  final restoreResult = await sl<SessionManager>().restore().run();
  restoreResult.match(
    (err) => sl<Talker>().error(
      'SessionManager.restore failed; continuing with fallback env',
      err,
    ),
    (hasSession) {
      sl<Talker>().info('SessionManager.restore: hasSession=$hasSession');
      if (hasSession) {
        sl<AlertEvaluator>().start();
      }
    },
  );

  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: sl<Talker>())],
      child: const BinanceApp(),
    ),
  );
}
