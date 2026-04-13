import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/price_alert.dart';
import '../providers/alerts_provider.dart';

/// Shows the create-alert dialog. [symbol] and [market] may be
/// pre-filled when opened from the symbol detail screen.
Future<void> showCreateAlertDialog(
  BuildContext context, {
  String? symbol,
  String? market,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _CreateAlertSheet(
      initialSymbol: symbol ?? '',
      initialMarket: market ?? 'spot',
    ),
  );
}

class _CreateAlertSheet extends ConsumerStatefulWidget {
  const _CreateAlertSheet({
    required this.initialSymbol,
    required this.initialMarket,
  });

  final String initialSymbol;
  final String initialMarket;

  @override
  ConsumerState<_CreateAlertSheet> createState() => _CreateAlertSheetState();
}

class _CreateAlertSheetState extends ConsumerState<_CreateAlertSheet> {
  late final TextEditingController _symbolController;
  late final TextEditingController _priceController;
  AlertDirection _direction = AlertDirection.above;
  late String _market;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _symbolController = TextEditingController(text: widget.initialSymbol);
    _priceController = TextEditingController();
    _market = widget.initialMarket;
  }

  @override
  void dispose() {
    _symbolController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  bool get _isValid {
    final symbol = _symbolController.text.trim();
    final priceText = _priceController.text.trim();
    if (symbol.isEmpty || priceText.isEmpty) return false;
    final parsed = Decimal.tryParse(priceText);
    return parsed != null && parsed > Decimal.zero;
  }

  Future<void> _submit() async {
    if (!_isValid || _submitting) return;

    setState(() => _submitting = true);

    final symbol = _symbolController.text.trim().toUpperCase();
    final price = Decimal.parse(_priceController.text.trim());

    await ref
        .read(alertsProvider.notifier)
        .createAlert(
          symbol: symbol,
          market: _market,
          direction: _direction,
          targetPrice: price,
        );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'New Price Alert',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _symbolController,
            decoration: const InputDecoration(
              labelText: 'Symbol',
              hintText: 'e.g. BTCUSDT',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'spot', label: Text('Spot')),
              ButtonSegment(value: 'futures', label: Text('Futures')),
            ],
            selected: {_market},
            onSelectionChanged: (v) => setState(() => _market = v.first),
          ),
          const SizedBox(height: 12),
          SegmentedButton<AlertDirection>(
            segments: const [
              ButtonSegment(
                value: AlertDirection.above,
                label: Text('Above'),
                icon: Icon(Icons.arrow_upward),
              ),
              ButtonSegment(
                value: AlertDirection.below,
                label: Text('Below'),
                icon: Icon(Icons.arrow_downward),
              ),
            ],
            selected: {_direction},
            onSelectionChanged: (v) => setState(() => _direction = v.first),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: 'Target Price',
              border: OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _isValid && !_submitting ? _submit : null,
            child: _submitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Create Alert'),
          ),
        ],
      ),
    );
  }
}
