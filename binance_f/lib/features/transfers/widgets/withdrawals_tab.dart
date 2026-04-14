import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/withdrawal.dart';
import '../providers/transfers_provider.dart';

/// Lists withdrawal history with pull-to-refresh.
class WithdrawalsTab extends ConsumerWidget {
  const WithdrawalsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncWithdrawals = ref.watch(withdrawalsProvider);

    return asyncWithdrawals.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => _ErrorView(
        message: err.toString(),
        onRetry: () => ref.read(withdrawalsProvider.notifier).refresh(),
      ),
      data: (withdrawals) => withdrawals.isEmpty
          ? const _EmptyState(label: 'No withdrawals found')
          : RefreshIndicator(
              onRefresh: () => ref.read(withdrawalsProvider.notifier).refresh(),
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: withdrawals.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) =>
                    _WithdrawalTile(withdrawal: withdrawals[index]),
              ),
            ),
    );
  }
}

class _WithdrawalTile extends StatelessWidget {
  const _WithdrawalTile({required this.withdrawal});

  final Withdrawal withdrawal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final statusColor = switch (withdrawal.status) {
      6 => Colors.green,
      4 => Colors.orange,
      1 || 3 || 5 => Colors.red,
      _ => scheme.outline,
    };

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: scheme.errorContainer,
        child: Text(
          withdrawal.coin.length > 3
              ? withdrawal.coin.substring(0, 3)
              : withdrawal.coin,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: scheme.onErrorContainer,
          ),
        ),
      ),
      title: Text('${withdrawal.amount} ${withdrawal.coin}'),
      subtitle: Text(
        '${withdrawal.network}  •  ${withdrawal.statusLabel}',
        style: TextStyle(color: statusColor, fontSize: 12),
      ),
      trailing: Text(
        _formatDate(withdrawal.applyDateTime),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () => _showWithdrawalDetail(context, withdrawal),
    );
  }
}

void _showWithdrawalDetail(BuildContext context, Withdrawal withdrawal) {
  showModalBottomSheet<void>(
    context: context,
    builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Withdrawal Detail',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _DetailRow(label: 'Coin', value: withdrawal.coin),
          _DetailRow(label: 'Amount', value: withdrawal.amount.toString()),
          _DetailRow(
            label: 'Fee',
            value: '${withdrawal.transactionFee} ${withdrawal.coin}',
          ),
          _DetailRow(label: 'Network', value: withdrawal.network),
          _DetailRow(label: 'Status', value: withdrawal.statusLabel),
          _DetailRow(label: 'Address', value: withdrawal.address),
          if (withdrawal.addressTag != null &&
              withdrawal.addressTag!.isNotEmpty)
            _DetailRow(label: 'Tag/Memo', value: withdrawal.addressTag!),
          _DetailRow(label: 'TxID', value: withdrawal.txId),
          _DetailRow(
            label: 'Time',
            value: withdrawal.applyDateTime.toLocal().toString(),
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
              child: Text(value, style: const TextStyle(fontSize: 13)),
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
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
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
