import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Available main indicators.
enum MainIndicatorType { none, ma, ema, boll }

/// Available secondary indicators.
enum SecondaryIndicatorType { none, macd, rsi, kdj, wr, cci }

/// State for chart UI settings (interval, visible indicators, drawings).
class ChartSettings {
  const ChartSettings({
    this.interval = '1m',
    this.mainIndicator = MainIndicatorType.ma,
    this.secondaryIndicator = SecondaryIndicatorType.none,
    this.isChartOnly = false,
    this.isTrendLine = false,
  });

  final String interval;
  final MainIndicatorType mainIndicator;
  final SecondaryIndicatorType secondaryIndicator;
  final bool isChartOnly;
  final bool isTrendLine;

  ChartSettings copyWith({
    String? interval,
    MainIndicatorType? mainIndicator,
    SecondaryIndicatorType? secondaryIndicator,
    bool? isChartOnly,
    bool? isTrendLine,
  }) {
    return ChartSettings(
      interval: interval ?? this.interval,
      mainIndicator: mainIndicator ?? this.mainIndicator,
      secondaryIndicator: secondaryIndicator ?? this.secondaryIndicator,
      isChartOnly: isChartOnly ?? this.isChartOnly,
      isTrendLine: isTrendLine ?? this.isTrendLine,
    );
  }
}

class ChartSettingsNotifier extends Notifier<ChartSettings> {
  @override
  ChartSettings build() => const ChartSettings();

  void setInterval(String interval) {
    state = state.copyWith(interval: interval);
  }

  void setMainIndicator(MainIndicatorType type) {
    state = state.copyWith(mainIndicator: type);
  }

  void setSecondaryIndicator(SecondaryIndicatorType type) {
    state = state.copyWith(secondaryIndicator: type);
  }

  void toggleChartOnly() {
    state = state.copyWith(isChartOnly: !state.isChartOnly);
  }

  void toggleTrendLine() {
    state = state.copyWith(isTrendLine: !state.isTrendLine);
  }
}

final chartSettingsProvider =
    NotifierProvider<ChartSettingsNotifier, ChartSettings>(
      ChartSettingsNotifier.new,
    );
