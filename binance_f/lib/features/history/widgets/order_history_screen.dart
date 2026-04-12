import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_history_tab.dart';

/// Standalone route wrapper for order history. Wraps [OrderHistoryTab]
/// in a Scaffold so it can be pushed as a full-screen route.
@RoutePage()
class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: const OrderHistoryTab(),
    );
  }
}
