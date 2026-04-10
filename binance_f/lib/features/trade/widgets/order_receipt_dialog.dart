import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../data/models/order_enums.dart';
import '../data/models/spot_order.dart';

/// Shows an order receipt after a successful placement (FR-5.5).
///
/// Displays status, fills, total quantity, average price, and fees.
Future<void> showOrderReceiptDialog({
  required BuildContext context,
  required SpotOrder order,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _OrderReceiptDialog(order: order),
  );
}

class _OrderReceiptDialog extends StatelessWidget {
  const _OrderReceiptDialog({required this.order});

  final SpotOrder order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBuy = order.side == OrderSide.BUY;
    final sideColor = isBuy ? Colors.green : Colors.red;

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            order.status == OrderStatus.FILLED
                ? Icons.check_circle
                : Icons.info_outline,
            color: order.status == OrderStatus.FILLED
                ? Colors.green
                : theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text('Order ${order.status.name}'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Row(label: 'Symbol', value: order.symbol),
            _Row(label: 'Side', value: order.side.name, valueColor: sideColor),
            _Row(label: 'Type', value: order.type.label),
            if (order.price > Decimal.zero)
              _Row(label: 'Price', value: order.price.toString()),
            _Row(label: 'Quantity', value: order.origQty.toString()),
            _Row(label: 'Filled', value: order.executedQty.toString()),
            if (order.avgPrice != null)
              _Row(label: 'Avg Price', value: order.avgPrice.toString()),
            _Row(
              label: 'Quote Total',
              value: order.cummulativeQuoteQty.toString(),
            ),
            if (order.fills.isNotEmpty) ...[
              const Divider(),
              Text('Fills', style: theme.textTheme.titleSmall),
              const SizedBox(height: 4),
              for (final fill in order.fills)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '${fill.qty} @ ${fill.price}  '
                    'fee: ${fill.commission} ${fill.commissionAsset}',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
            ],
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Done'),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
