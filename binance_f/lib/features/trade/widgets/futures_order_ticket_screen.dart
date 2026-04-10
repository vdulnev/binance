import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/app_exception.dart';
import '../../markets/data/models/ticker_24h.dart';
import '../../markets/providers/tickers_provider.dart';
import '../data/models/futures_order.dart';
import '../data/models/order_enums.dart';
import '../providers/futures_trade_provider.dart';
import 'confirmation_dialog.dart';

/// Futures order ticket with reduce-only / post-only toggles and
/// futures-specific order types (STOP_MARKET, TRAILING_STOP_MARKET, etc.).
@RoutePage()
class FuturesOrderTicketScreen extends ConsumerStatefulWidget {
  const FuturesOrderTicketScreen({
    super.key,
    @PathParam('symbol') required this.symbol,
  });

  final String symbol;

  @override
  ConsumerState<FuturesOrderTicketScreen> createState() =>
      _FuturesOrderTicketScreenState();
}

class _FuturesOrderTicketScreenState
    extends ConsumerState<FuturesOrderTicketScreen> {
  OrderSide _side = OrderSide.BUY;
  OrderType _type = OrderType.LIMIT;
  TimeInForce _tif = TimeInForce.GTC;
  bool _reduceOnly = false;
  bool _postOnly = false;

  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _stopPriceController = TextEditingController();
  final _callbackRateController = TextEditingController();

  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _priceController.dispose();
    _qtyController.dispose();
    _stopPriceController.dispose();
    _callbackRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tickers = ref.watch(tickersProvider('futures'));
    final ticker = tickers.value?[widget.symbol];

    return Scaffold(
      appBar: AppBar(title: Text('${widget.symbol} Futures')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (ticker != null) _TickerRow(ticker: ticker),
            const SizedBox(height: 16),

            // Side toggle
            _SideToggle(
              side: _side,
              onChanged: (s) => setState(() => _side = s),
            ),
            const SizedBox(height: 16),

            // Order type
            DropdownButtonFormField<OrderType>(
              initialValue: _type,
              decoration: const InputDecoration(
                labelText: 'Order Type',
                border: OutlineInputBorder(),
              ),
              items: futuresOrderTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                  .toList(),
              onChanged: (t) {
                if (t == null) return;
                setState(() => _type = t);
              },
            ),
            const SizedBox(height: 12),

            // Price
            if (_type.hasPrice)
              _Field(
                controller: _priceController,
                label: 'Price',
                ticker: ticker,
              ),

            // Stop price
            if (_type.hasStopPrice)
              _Field(controller: _stopPriceController, label: 'Stop Price'),

            // Callback rate (trailing stop)
            if (_type.hasCallbackRate)
              _Field(
                controller: _callbackRateController,
                label: 'Callback Rate (%)',
              ),

            // Quantity
            _Field(controller: _qtyController, label: 'Quantity'),

            // TimeInForce
            if (_type.hasTimeInForce)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SegmentedButton<TimeInForce>(
                  segments: TimeInForce.values
                      .map((t) => ButtonSegment(value: t, label: Text(t.name)))
                      .toList(),
                  selected: {_tif},
                  onSelectionChanged: (s) => setState(() => _tif = s.first),
                ),
              ),

            // Reduce-only / Post-only toggles
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Reduce Only'),
                    value: _reduceOnly,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (v) => setState(() => _reduceOnly = v ?? false),
                  ),
                ),
                if (_type == OrderType.LIMIT)
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Post Only'),
                      value: _postOnly,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (v) => setState(() => _postOnly = v ?? false),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // Error
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _error!,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),

            // Submit
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _side == OrderSide.BUY
                    ? Colors.green
                    : Colors.red,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: _submitting ? null : _onSubmit,
              child: _submitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      '${_side.name} ${widget.symbol}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    setState(() {
      _error = null;
      _submitting = true;
    });

    final qty = Decimal.tryParse(_qtyController.text.trim());
    if (qty == null || qty <= Decimal.zero) {
      setState(() {
        _error = 'Enter a valid quantity.';
        _submitting = false;
      });
      return;
    }

    Decimal? price;
    if (_type.hasPrice) {
      price = Decimal.tryParse(_priceController.text.trim());
      if (price == null || price <= Decimal.zero) {
        setState(() {
          _error = 'Enter a valid price.';
          _submitting = false;
        });
        return;
      }
    }

    Decimal? stopPrice;
    if (_type.hasStopPrice) {
      stopPrice = Decimal.tryParse(_stopPriceController.text.trim());
      if (stopPrice == null || stopPrice <= Decimal.zero) {
        setState(() {
          _error = 'Enter a valid stop price.';
          _submitting = false;
        });
        return;
      }
    }

    Decimal? callbackRate;
    if (_type.hasCallbackRate) {
      callbackRate = Decimal.tryParse(_callbackRateController.text.trim());
      if (callbackRate == null || callbackRate <= Decimal.zero) {
        setState(() {
          _error = 'Enter a valid callback rate.';
          _submitting = false;
        });
        return;
      }
    }

    // FR-5.4: Confirmation.
    final confirmed = await showConfirmationDialog(
      context: context,
      title: '${_side.name} ${widget.symbol}',
      content: _buildSummary(qty, price, stopPrice, callbackRate),
      confirmLabel: _side == OrderSide.BUY ? 'Buy' : 'Sell',
    );

    if (confirmed != true) {
      setState(() => _submitting = false);
      return;
    }

    try {
      final order = await ref
          .read(futuresTradeProvider.notifier)
          .placeOrder(
            symbol: widget.symbol,
            side: _side,
            type: _type,
            quantity: qty,
            price: price,
            stopPrice: stopPrice,
            callbackRate: callbackRate,
            timeInForce: _type.hasTimeInForce ? _tif : null,
            reduceOnly: _reduceOnly,
            postOnly: _postOnly,
          );

      if (!mounted) return;
      setState(() => _submitting = false);

      await _showReceipt(order);
      if (mounted) context.router.maybePop();
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.displayMessage;
        _submitting = false;
      });
    } on Exception catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _submitting = false;
      });
    }
  }

  Widget _buildSummary(
    Decimal qty,
    Decimal? price,
    Decimal? stopPrice,
    Decimal? callbackRate,
  ) {
    final lines = <String>[
      'Type: ${_type.label}',
      'Side: ${_side.name}',
      'Quantity: $qty',
      if (price != null) 'Price: $price',
      if (stopPrice != null) 'Stop Price: $stopPrice',
      if (callbackRate != null) 'Callback Rate: $callbackRate%',
      if (_reduceOnly) 'Reduce Only: Yes',
      if (_postOnly) 'Post Only: Yes',
      if (_type.hasTimeInForce) 'TIF: ${_tif.name}',
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines
          .map((l) => Text(l, style: Theme.of(context).textTheme.bodyMedium))
          .toList(),
    );
  }

  Future<void> _showReceipt(FuturesOrder order) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Text('Order ${order.status.name}'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${order.side.name} ${order.origQty} ${order.symbol}'),
            if (order.price > Decimal.zero) Text('Price: ${order.price}'),
            Text('Status: ${order.status.name}'),
            if (order.reduceOnly) Text('Reduce Only'),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------
// Sub-widgets
// ------------------------------------------------------------------

class _TickerRow extends StatelessWidget {
  const _TickerRow({required this.ticker});

  final Ticker24h ticker;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final changeColor = ticker.isPositive ? Colors.green : Colors.red;
    return Row(
      children: [
        Text(
          ticker.lastPrice.toString(),
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: changeColor.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${ticker.isPositive ? '+' : ''}'
            '${ticker.priceChangePercent.toStringAsFixed(2)}%',
            style: theme.textTheme.labelMedium?.copyWith(
              color: changeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _SideToggle extends StatelessWidget {
  const _SideToggle({required this.side, required this.onChanged});

  final OrderSide side;
  final ValueChanged<OrderSide> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<OrderSide>(
      segments: const [
        ButtonSegment(
          value: OrderSide.BUY,
          label: Text('LONG'),
          icon: Icon(Icons.arrow_upward),
        ),
        ButtonSegment(
          value: OrderSide.SELL,
          label: Text('SHORT'),
          icon: Icon(Icons.arrow_downward),
        ),
      ],
      selected: {side},
      onSelectionChanged: (s) => onChanged(s.first),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (!states.contains(WidgetState.selected)) return null;
          return side == OrderSide.BUY
              ? Colors.green.withAlpha(40)
              : Colors.red.withAlpha(40);
        }),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.controller, required this.label, this.ticker});

  final TextEditingController controller;
  final String label;
  final Ticker24h? ticker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: ticker != null
              ? IconButton(
                  icon: const Icon(Icons.auto_fix_high),
                  tooltip: 'Use last price',
                  onPressed: () {
                    controller.text = ticker!.lastPrice.toString();
                  },
                )
              : null,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
