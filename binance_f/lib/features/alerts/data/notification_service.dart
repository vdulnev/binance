import 'package:decimal/decimal.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'models/price_alert.dart';

/// Thin wrapper around [FlutterLocalNotificationsPlugin] for
/// price-alert delivery (Phase 9 — FR-7.3).
///
/// Initialised once in `main.dart` via [initialize], then used by
/// [AlertEvaluator]'s `onTriggered` callback.
class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'price_alerts';
  static const _channelName = 'Price Alerts';
  static const _channelDescription =
      'Notifications when a price alert threshold is crossed';

  /// Must be called before `runApp`, after
  /// `WidgetsFlutterBinding.ensureInitialized()`.
  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings();
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open',
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
      linux: linuxSettings,
    );

    await _plugin.initialize(settings: initSettings);
  }

  /// Request notification permission if not already granted. Safe to
  /// call multiple times. Returns `true` if granted.
  static Future<bool> requestPermissionIfNeeded() async {
    // Android 13+ requires explicit permission.
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }

    // iOS / macOS request via Darwin implementation.
    final darwin = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (darwin != null) {
      return await darwin.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    final macos = _plugin.resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>();
    if (macos != null) {
      return await macos.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    return true;
  }

  /// Fire a local notification for a triggered alert.
  Future<void> showAlertNotification(
    PriceAlert alert,
    Decimal currentPrice,
  ) async {
    final directionLabel =
        alert.direction == AlertDirection.above ? 'above' : 'below';

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );
    const darwinDetails = DarwinNotificationDetails();
    const linuxDetails = LinuxNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
      linux: linuxDetails,
    );

    await _plugin.show(
      id: alert.id,
      title: '${alert.symbol} Price Alert',
      body: '${alert.symbol} crossed $directionLabel '
          '${alert.targetPrice} — now at $currentPrice',
      notificationDetails: details,
    );
  }
}
