import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'alerts_tab.dart';

/// Standalone route wrapper for price alerts. Wraps [AlertsTab]
/// in a Scaffold so it can be pushed as a full-screen route.
@RoutePage()
class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Alerts')),
      body: const AlertsTab(),
    );
  }
}
