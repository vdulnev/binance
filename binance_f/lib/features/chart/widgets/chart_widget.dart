import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_chart_plus/k_chart_plus.dart';

import '../providers/chart_provider.dart';
import '../providers/chart_settings_provider.dart';
import 'popup_info_view.dart';

class ChartWidget extends ConsumerStatefulWidget {
  const ChartWidget({super.key, required this.symbol, this.market = 'spot'});

  final String symbol;
  final String market;

  @override
  ConsumerState<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends ConsumerState<ChartWidget> {
  static const _intervals = [
    '1m',
    '3m',
    '5m',
    '15m',
    '30m',
    '1h',
    '2h',
    '4h',
    '6h',
    '8h',
    '12h',
    '1d',
    '3d',
    '1w',
    '1M',
  ];

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(chartSettingsProvider);
    final params = ChartParams(
      symbol: widget.symbol,
      market: widget.market,
      interval: settings.interval,
    );
    final klines = ref.watch(chartProvider(params));

    return Column(
      children: [
        // Top Toolbar: Interval Selector
        _IntervalToolbar(
          intervals: _intervals,
          selected: settings.interval,
          onSelected: (val) =>
              ref.read(chartSettingsProvider.notifier).setInterval(val),
        ),
        // Indicators Toolbar
        _IndicatorsToolbar(
          mainIndicator: settings.mainIndicator,
          secondaryIndicator: settings.secondaryIndicator,
          isTrendLine: settings.isTrendLine,
          onMainChanged: (val) =>
              ref.read(chartSettingsProvider.notifier).setMainIndicator(val),
          onSecondaryChanged: (val) => ref
              .read(chartSettingsProvider.notifier)
              .setSecondaryIndicator(val),
          onTrendLineToggled: () =>
              ref.read(chartSettingsProvider.notifier).toggleTrendLine(),
        ),
        // Chart
        Expanded(
          child: klines.when(
            data: (data) => KChartWidget(
              data,
              const KChartStyle(),
              const KChartColors(),
              isLine: false,
              mainIndicators: [
                if (settings.mainIndicator == MainIndicatorType.ma)
                  MAIndicator(calcParams: [7, 25, 99]),
                if (settings.mainIndicator == MainIndicatorType.ema)
                  EMAIndicator(calcParams: [7, 25, 99]),
                if (settings.mainIndicator == MainIndicatorType.boll)
                  BOLLIndicator(),
              ],
              secondaryIndicators: [
                if (settings.secondaryIndicator == SecondaryIndicatorType.macd)
                  MACDIndicator(),
                if (settings.secondaryIndicator == SecondaryIndicatorType.rsi)
                  RSIIndicator(),
                if (settings.secondaryIndicator == SecondaryIndicatorType.kdj)
                  KDJIndicator(),
                if (settings.secondaryIndicator == SecondaryIndicatorType.wr)
                  WRIndicator(),
                if (settings.secondaryIndicator == SecondaryIndicatorType.cci)
                  CCIIndicator(),
              ],
              volHidden: false,
              showNowPrice: true,
              isTrendLine: settings.isTrendLine,
              xFrontPadding: 100,
              detailBuilder: (entity) => PopupInfoView(
                entity: entity,
                chartColors: const KChartColors(),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }
}

class _IntervalToolbar extends StatelessWidget {
  const _IntervalToolbar({
    required this.intervals,
    required this.selected,
    required this.onSelected,
  });

  final List<String> intervals;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: intervals.map((i) {
          final isSelected = i == selected;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(i),
              selected: isSelected,
              onSelected: (val) => onSelected(i),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _IndicatorsToolbar extends StatelessWidget {
  const _IndicatorsToolbar({
    required this.mainIndicator,
    required this.secondaryIndicator,
    required this.isTrendLine,
    required this.onMainChanged,
    required this.onSecondaryChanged,
    required this.onTrendLineToggled,
  });

  final MainIndicatorType mainIndicator;
  final SecondaryIndicatorType secondaryIndicator;
  final bool isTrendLine;
  final ValueChanged<MainIndicatorType> onMainChanged;
  final ValueChanged<SecondaryIndicatorType> onSecondaryChanged;
  final VoidCallback onTrendLineToggled;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          _IndicatorGroup(
            label: 'Main',
            options: MainIndicatorType.values,
            selected: mainIndicator,
            onChanged: (val) => onMainChanged(val as MainIndicatorType),
          ),
          const SizedBox(width: 16),
          _IndicatorGroup(
            label: 'Sub',
            options: SecondaryIndicatorType.values,
            selected: secondaryIndicator,
            onChanged: (val) =>
                onSecondaryChanged(val as SecondaryIndicatorType),
          ),
          const SizedBox(width: 16),
          _StatelessToggleButton(
            label: 'Draw',
            isSelected: isTrendLine,
            onPressed: onTrendLineToggled,
          ),
        ],
      ),
    );
  }
}

class _IndicatorGroup extends StatelessWidget {
  const _IndicatorGroup({
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final String label;
  final List<dynamic> options;
  final dynamic selected;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label:',
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        ...options.map((o) {
          final isSelected = o == selected;
          final name = o.toString().split('.').last.toUpperCase();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: OutlinedButton(
              onPressed: () => onChanged(o),
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                backgroundColor: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                side: isSelected
                    ? BorderSide(color: Theme.of(context).colorScheme.primary)
                    : null,
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _StatelessToggleButton extends StatelessWidget {
  const _StatelessToggleButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: isSelected ? theme.colorScheme.primaryContainer : null,
        side: isSelected ? BorderSide(color: theme.colorScheme.primary) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: isSelected ? theme.colorScheme.onPrimaryContainer : null,
        ),
      ),
    );
  }
}
