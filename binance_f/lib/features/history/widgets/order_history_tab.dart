import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/app_exception.dart';
import '../providers/order_history_provider.dart';

/// Embeddable order history content used inside the home screen's
/// bottom nav. The standalone [OrderHistoryScreen] wraps this in a
/// Scaffold for direct-route access.
class OrderHistoryTab extends ConsumerStatefulWidget {
  const OrderHistoryTab({super.key});

  @override
  ConsumerState<OrderHistoryTab> createState() => _OrderHistoryTabState();
}

class _OrderHistoryTabState extends ConsumerState<OrderHistoryTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _symbolController = TextEditingController(text: 'BTCUSDT');
  DateTimeRange? _dateRange;

  String get _market => _tabController.index == 0 ? 'spot' : 'futures';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _search());
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    _symbolController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      _search();
    }
  }

  void _search() {
    final symbol = _symbolController.text.trim().toUpperCase();
    if (symbol.isEmpty) return;
    ref
        .read(orderHistoryProvider.notifier)
        .loadOrders(
          symbol: symbol,
          market: _market,
          startTime: _dateRange?.start,
          endTime: _dateRange?.end,
        );
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2017),
      lastDate: now,
      initialDateRange:
          _dateRange ??
          DateTimeRange(
            start: now.subtract(const Duration(days: 30)),
            end: now,
          ),
    );
    if (picked != null) {
      setState(() => _dateRange = picked);
      _search();
    }
  }

  void _clearDateRange() {
    setState(() => _dateRange = null);
    _search();
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(orderHistoryProvider);

    return Column(
      children: [
        // Market tabs
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Spot'),
            Tab(text: 'Futures'),
          ],
        ),
        // Symbol search + date filter
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _symbolController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    hintText: 'Symbol (e.g. BTCUSDT)',
                    prefixIcon: Icon(Icons.search),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onSubmitted: (_) => _search(),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: Icon(
                  _dateRange != null
                      ? Icons.date_range
                      : Icons.date_range_outlined,
                ),
                tooltip: 'Filter by date',
                onPressed: _pickDateRange,
              ),
              const SizedBox(width: 4),
              FilledButton(onPressed: _search, child: const Text('Go')),
            ],
          ),
        ),
        // Active date filter chip
        if (_dateRange != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                label: Text(
                  '${_fmtDate(_dateRange!.start)}'
                  ' – ${_fmtDate(_dateRange!.end)}',
                ),
                onDeleted: _clearDateRange,
              ),
            ),
          ),
        // Results
        Expanded(
          child: historyState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => _ErrorBody(error: err, onRetry: _search),
            data: (data) => _OrderList(
              orders: data.orders,
              stale: data.stale,
              onRefresh: _search,
            ),
          ),
        ),
      ],
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}'
      '-${d.day.toString().padLeft(2, '0')}';
}

// ------------------------------------------------------------------
// Order list
// ------------------------------------------------------------------

class _OrderList extends StatelessWidget {
  const _OrderList({
    required this.orders,
    required this.stale,
    required this.onRefresh,
  });

  final List<HistoryOrder> orders;
  final bool stale;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'No orders found',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (stale)
          MaterialBanner(
            content: const Text('Showing cached data (offline)'),
            leading: const Icon(Icons.cloud_off),
            actions: [
              TextButton(onPressed: onRefresh, child: const Text('Retry')),
            ],
          ),
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) => _OrderTile(order: orders[index]),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------
// Single order tile
// ------------------------------------------------------------------

class _OrderTile extends StatelessWidget {
  const _OrderTile({required this.order});

  final HistoryOrder order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBuy = order.side == 'BUY';
    final sideColor = isBuy ? Colors.green : Colors.red;
    final statusColor = switch (order.status) {
      'FILLED' => Colors.green,
      'CANCELED' || 'EXPIRED' || 'REJECTED' => theme.colorScheme.outline,
      _ => theme.colorScheme.primary,
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: side + type + status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: sideColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    order.side,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: sideColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _humanType(order.type),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (order.reduceOnly) ...[
                  const SizedBox(width: 6),
                  Text(
                    'R/O',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                ],
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    order.status,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Details
            Row(
              children: [
                _Detail(label: 'Price', value: order.price),
                _Detail(label: 'Avg', value: order.avgPrice),
                _Detail(label: 'Qty', value: order.origQty),
                _Detail(label: 'Filled', value: order.executedQty),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _fmtDateTime(order.time),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _humanType(String type) => switch (type) {
    'MARKET' => 'Market',
    'LIMIT' => 'Limit',
    'STOP_LOSS' => 'Stop Loss',
    'STOP_LOSS_LIMIT' => 'Stop Limit',
    'TAKE_PROFIT' => 'Take Profit',
    'TAKE_PROFIT_LIMIT' => 'TP Limit',
    'LIMIT_MAKER' => 'Limit Maker',
    'STOP_MARKET' => 'Stop Market',
    'TAKE_PROFIT_MARKET' => 'TP Market',
    'TRAILING_STOP_MARKET' => 'Trailing',
    _ => type,
  };

  String _fmtDateTime(DateTime dt) {
    final local = dt.toLocal();
    return '${local.year}-'
        '${local.month.toString().padLeft(2, '0')}-'
        '${local.day.toString().padLeft(2, '0')} '
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------
// Error body
// ------------------------------------------------------------------

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = error is AppException
        ? (error as AppException).displayMessage
        : error.toString();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(message, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
