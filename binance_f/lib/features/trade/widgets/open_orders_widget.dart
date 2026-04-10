import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/order_enums.dart';
import '../data/models/spot_order.dart';
import '../providers/open_orders_provider.dart';
import 'confirmation_dialog.dart';

/// Displays the user's open spot orders with cancel functionality.
///
/// Used in the SymbolDetailScreen as an additional tab (Phase 5).
/// Each row shows order type, side, price, qty, filled %, and a
/// cancel button that goes through the confirmation dialog (FR-5.4).
class OpenOrdersWidget extends ConsumerWidget {
  const OpenOrdersWidget({super.key, this.symbol});

  /// If non-null, filters to only orders for this symbol.
  final String? symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(openOrdersProvider);

    return orders.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Failed to load orders',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.read(openOrdersProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (allOrders) {
        final filtered = symbol != null
            ? allOrders.where((o) => o.symbol == symbol).toList()
            : allOrders;

        if (filtered.isEmpty) {
          return const Center(child: Text('No open orders'));
        }
        return _OrdersList(orders: filtered);
      },
    );
  }
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({required this.orders});

  final List<SpotOrder> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) => _OrderRow(order: orders[index]),
    );
  }
}

class _OrderRow extends ConsumerWidget {
  const _OrderRow({required this.order});

  final SpotOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isBuy = order.side == OrderSide.BUY;
    final sideColor = isBuy ? Colors.green : Colors.red;
    final filledPct = order.origQty > Decimal.zero
        ? ((order.executedQty / order.origQty).toDouble() * 100)
              .toStringAsFixed(1)
        : '0.0';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Side badge
          Container(
            width: 40,
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: sideColor.withAlpha(30),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              order.side.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: sideColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Order details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${order.type.label}  '
                  '${order.origQty} @ '
                  '${order.price > Decimal.zero ? order.price : "MKT"}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Filled: $filledPct%  |  '
                  '${order.status.name}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Cancel button
          IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              color: theme.colorScheme.error,
              size: 20,
            ),
            tooltip: 'Cancel order',
            onPressed: () => _onCancel(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _onCancel(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmationDialog(
      context: context,
      title: 'Cancel Order',
      content: Text(
        'Cancel ${order.side.name} ${order.origQty} '
        '${order.symbol} @ ${order.price}?',
      ),
      confirmLabel: 'Cancel Order',
      destructive: true,
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    try {
      await ref
          .read(openOrdersProvider.notifier)
          .cancel(symbol: order.symbol, orderId: order.orderId);
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Order cancelled')));
    } on Exception catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Cancel failed: $e')));
    }
  }
}
