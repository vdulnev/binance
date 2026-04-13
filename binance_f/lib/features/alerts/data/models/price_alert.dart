import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'price_alert.freezed.dart';
part 'price_alert.g.dart';

/// Direction the price must cross for an alert to trigger.
enum AlertDirection {
  above,
  below;

  /// Parses from Drift text column value.
  static AlertDirection fromString(String value) =>
      AlertDirection.values.firstWhere((e) => e.name == value);
}

/// A user-created local price alert (Phase 9 — FR-7.1).
///
/// Stored in the Drift `price_alerts` table and evaluated against the
/// live ticker stream by [AlertEvaluator].
@Freezed(toJson: true, fromJson: true)
sealed class PriceAlert with _$PriceAlert {
  const PriceAlert._();

  const factory PriceAlert({
    required int id,
    required String symbol,
    required String market,
    required AlertDirection direction,
    @DecimalConverter() required Decimal targetPrice,
    @Default(true) bool enabled,
    required DateTime createdAt,
    DateTime? triggeredAt,
  }) = _PriceAlert;

  factory PriceAlert.fromJson(Map<String, dynamic> json) =>
      _$PriceAlertFromJson(json);

  /// Whether this alert has already been triggered.
  bool get isTriggered => triggeredAt != null;
}
