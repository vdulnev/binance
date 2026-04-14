import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/transfers_provider.dart';

/// Shows the deposit address for a given coin as a bottom sheet.
Future<void> showDepositAddressSheet(
  BuildContext context, {
  required String coin,
}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (_) => _DepositAddressContent(coin: coin),
  );
}

class _DepositAddressContent extends ConsumerWidget {
  const _DepositAddressContent({required this.coin});

  final String coin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAddr = ref.watch(depositAddressProvider(coin));

    return Padding(
      padding: const EdgeInsets.all(24),
      child: asyncAddr.when(
        loading: () => const SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (err, _) => SizedBox(
          height: 120,
          child: Center(
            child: Text(
              'Failed to load address:\n$err',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (addr) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$coin Deposit Address',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            _CopyableField(label: 'Address', value: addr.address),
            if (addr.tag != null && addr.tag!.isNotEmpty)
              _CopyableField(label: 'Tag / Memo', value: addr.tag!),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _CopyableField extends StatelessWidget {
  const _CopyableField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: scheme.outline),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SelectableText(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: 'Copy',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$label copied'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
