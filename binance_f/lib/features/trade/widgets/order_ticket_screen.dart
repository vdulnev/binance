import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/app_exception.dart';
import '../../markets/data/models/ticker_24h.dart';
import '../../markets/providers/tickers_provider.dart';
import '../data/models/order_enums.dart';
import '../providers/spot_trade_provider.dart';
import 'confirmation_dialog.dart';
import 'order_receipt_dialog.dart';

/// Order ticket for placing spot orders on a given [symbol].
///
/// Supports all order types from FR-5.1. The form dynamically shows/hides
/// fields based on the selected order type. Price defaults to the last
/// ticker price for limit-type orders.
@RoutePage()
class OrderTicketScreen extends ConsumerStatefulWidget {
  const OrderTicketScreen({
    super.key,
    @PathParam('symbol') required this.symbol,
  });

  final String symbol;

  @override
  ConsumerState<OrderTicketScreen> createState() => _OrderTicketScreenState();
}

class _OrderTicketScreenState extends ConsumerState<OrderTicketScreen> {
  OrderSide _side = OrderSide.BUY;
  OrderType _type = OrderType.LIMIT;
  TimeInForce _tif = TimeInForce.GTC;

  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _stopPriceController = TextEditingController();

  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _priceController.dispose();
    _qtyController.dispose();
    _stopPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tickers = ref.watch(tickersProvider('spot'));
    final ticker = tickers.value?[widget.symbol];

    return Scaffold(
      appBar: AppBar(title: Text('${widget.symbol} Order')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ticker summary
            if (ticker != null) _TickerSummary(ticker: ticker),
            const SizedBox(height: 16),

            // Side toggle
            _SideSelector(
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
              items: OrderType.values
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
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: const OutlineInputBorder(),
                    suffixIcon: ticker != null
                        ? IconButton(
                            icon: const Icon(Icons.auto_fix_high),
                            tooltip: 'Use last price',
                            onPressed: () {
                              _priceController.text = ticker.lastPrice
                                  .toString();
                            },
                          )
                        : null,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),

            // Stop price
            if (_type.hasStopPrice)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: _stopPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Stop Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),

            // Quantity
            TextField(
              controller: _qtyController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 12),

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
            const SizedBox(height: 8),
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

    // FR-5.4: Confirmation dialog before submission.
    final confirmed = await showConfirmationDialog(
      context: context,
      title: '${_side.name} ${widget.symbol}',
      content: _OrderSummary(
        type: _type,
        side: _side,
        quantity: qty,
        price: price,
        stopPrice: stopPrice,
        tif: _type.hasTimeInForce ? _tif : null,
      ),
      confirmLabel: _side == OrderSide.BUY ? 'Buy' : 'Sell',
    );

    if (confirmed != true) {
      setState(() => _submitting = false);
      return;
    }

    try {
      final order = await ref
          .read(spotTradeProvider.notifier)
          .placeOrder(
            symbol: widget.symbol,
            side: _side,
            type: _type,
            quantity: qty,
            price: price,
            stopPrice: stopPrice,
            timeInForce: _type.hasTimeInForce ? _tif : null,
          );

      if (!mounted) return;
      setState(() => _submitting = false);

      // FR-5.5: Show order receipt.
      await showOrderReceiptDialog(context: context, order: order);
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
}

// ------------------------------------------------------------------
// Sub-widgets
// ------------------------------------------------------------------

class _TickerSummary extends StatelessWidget {
  const _TickerSummary({required this.ticker});

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

class _SideSelector extends StatelessWidget {
  const _SideSelector({required this.side, required this.onChanged});

  final OrderSide side;
  final ValueChanged<OrderSide> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<OrderSide>(
      segments: const [
        ButtonSegment(
          value: OrderSide.BUY,
          label: Text('BUY'),
          icon: Icon(Icons.arrow_upward),
        ),
        ButtonSegment(
          value: OrderSide.SELL,
          label: Text('SELL'),
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

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({
    required this.type,
    required this.side,
    required this.quantity,
    this.price,
    this.stopPrice,
    this.tif,
  });

  final OrderType type;
  final OrderSide side;
  final Decimal quantity;
  final Decimal? price;
  final Decimal? stopPrice;
  final TimeInForce? tif;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Type: ${type.label}', style: theme.textTheme.bodyMedium),
        Text('Side: ${side.name}', style: theme.textTheme.bodyMedium),
        Text('Quantity: $quantity', style: theme.textTheme.bodyMedium),
        if (price != null)
          Text('Price: $price', style: theme.textTheme.bodyMedium),
        if (stopPrice != null)
          Text('Stop Price: $stopPrice', style: theme.textTheme.bodyMedium),
        if (tif != null)
          Text(
            'Time in Force: ${tif!.name}',
            style: theme.textTheme.bodyMedium,
          ),
        if (price != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Total: ${(price! * quantity).toStringAsFixed(8)}',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
