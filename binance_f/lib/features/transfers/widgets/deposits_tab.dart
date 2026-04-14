import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/deposit.dart';
import '../providers/transfers_provider.dart';

/// Lists deposit history with pull-to-refresh.
class DepositsTab extends ConsumerWidget {
  const DepositsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDeposits = ref.watch(depositsProvider);

    return asyncDeposits.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => _ErrorView(
        message: err.toString(),
        onRetry: () => ref.read(depositsProvider.notifier).refresh(),
      ),
      data: (deposits) => deposits.isEmpty
          ? const _EmptyState(label: 'No deposits found')
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(depositsProvider.notifier).refresh(),
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: deposits.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) =>
                    _DepositTile(deposit: deposits[index]),
              ),
            ),
    );
  }
}

class _DepositTile extends StatelessWidget {
  const _DepositTile({required this.deposit});

  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final statusColor = switch (deposit.status) {
      1 || 6 => Colors.green,
      0 => Colors.orange,
      _ => scheme.outline,
    };

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: scheme.primaryContainer,
        child: Text(
          deposit.coin.length > 3
              ? deposit.coin.substring(0, 3)
              : deposit.coin,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: scheme.onPrimaryContainer,
          ),
        ),
      ),
      title: Text('${deposit.amount} ${deposit.coin}'),
      subtitle: Text(
        '${deposit.network}  •  ${deposit.statusLabel}',
        style: TextStyle(color: statusColor, fontSize: 12),
      ),
      trailing: Text(
        _formatDate(deposit.insertDateTime),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () => _showDepositDetail(context, deposit),
    );
  }
}

void _showDepositDetail(BuildContext context, Deposit deposit) {
  showModalBottomSheet<void>(
    context: context,
    builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deposit Detail',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _DetailRow(label: 'Coin', value: deposit.coin),
          _DetailRow(label: 'Amount', value: deposit.amount.toString()),
          _DetailRow(label: 'Network', value: deposit.network),
          _DetailRow(label: 'Status', value: deposit.statusLabel),
          _DetailRow(label: 'Address', value: deposit.address),
          if (deposit.addressTag != null && deposit.addressTag!.isNotEmpty)
            _DetailRow(label: 'Tag/Memo', value: deposit.addressTag!),
          _DetailRow(label: 'TxID', value: deposit.txId),
          _DetailRow(
            label: 'Time',
            value: deposit.insertDateTime.toLocal().toString(),
          ),
        ],
      ),
    ),
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label copied'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Text(
                value,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime dt) {
  final local = dt.toLocal();
  return '${local.month}/${local.day}/${local.year}';
}
