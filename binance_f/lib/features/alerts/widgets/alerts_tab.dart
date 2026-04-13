import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/price_alert.dart';
import '../providers/alerts_provider.dart';
import 'alert_tile.dart';
import 'create_alert_dialog.dart';

/// Embeddable price-alerts content used inside the home screen's
/// bottom nav. The standalone [AlertsScreen] wraps this in a
/// Scaffold for direct-route access.
class AlertsTab extends ConsumerWidget {
  const AlertsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAlerts = ref.watch(alertsProvider);

    return asyncAlerts.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Failed to load alerts:\n$err',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (alerts) => _AlertsBody(alerts: alerts),
    );
  }
}

class _AlertsBody extends ConsumerWidget {
  const _AlertsBody({required this.alerts});

  final List<PriceAlert> alerts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const _BackgroundCaveatBanner(),
        Expanded(
          child: alerts.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: alerts.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final alert = alerts[index];
                    return AlertTile(
                      alert: alert,
                      onToggle: (enabled) => ref
                          .read(alertsProvider.notifier)
                          .toggleEnabled(alert.id, enabled: enabled),
                      onDelete: () => ref
                          .read(alertsProvider.notifier)
                          .deleteAlert(alert.id),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () => showCreateAlertDialog(context),
            icon: const Icon(Icons.add_alert),
            label: const Text('New Alert'),
          ),
        ),
      ],
    );
  }
}

/// FR-7.2 / EC-12: document platform background limitations.
class _BackgroundCaveatBanner extends StatelessWidget {
  const _BackgroundCaveatBanner();

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        Icons.info_outline,
        color: Theme.of(context).colorScheme.primary,
      ),
      content: const Text(
        'Alerts are evaluated while the app is running. '
        'Notifications may be delayed when the app is in the background.',
        style: TextStyle(fontSize: 12),
      ),
      actions: const [SizedBox.shrink()],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No price alerts yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Create an alert to get notified when a symbol '
              'crosses your target price.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
