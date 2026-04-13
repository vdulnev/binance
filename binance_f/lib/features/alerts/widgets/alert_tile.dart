import 'package:flutter/material.dart';

import '../data/models/price_alert.dart';

/// A single row in the price alerts list.
class AlertTile extends StatelessWidget {
  const AlertTile({
    required this.alert,
    required this.onToggle,
    required this.onDelete,
    super.key,
  });

  final PriceAlert alert;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAbove = alert.direction == AlertDirection.above;

    return Dismissible(
      key: ValueKey(alert.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: scheme.error,
        child: Icon(Icons.delete, color: scheme.onError),
      ),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        leading: Icon(
          isAbove ? Icons.arrow_upward : Icons.arrow_downward,
          color: isAbove ? Colors.green : Colors.red,
        ),
        title: Text(alert.symbol),
        subtitle: Text(
          '${isAbove ? 'Above' : 'Below'} ${alert.targetPrice}'
          '${alert.isTriggered ? '  •  Triggered' : ''}',
          style: alert.isTriggered ? TextStyle(color: scheme.outline) : null,
        ),
        trailing: alert.isTriggered
            ? Chip(
                label: Text(
                  'Triggered',
                  style: TextStyle(
                    fontSize: 11,
                    color: scheme.onTertiaryContainer,
                  ),
                ),
                backgroundColor: scheme.tertiaryContainer,
                visualDensity: VisualDensity.compact,
              )
            : Switch.adaptive(value: alert.enabled, onChanged: onToggle),
      ),
    );
  }
}
