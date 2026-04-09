import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/serialization/decimal_converter.dart';

part 'total_value_result.freezed.dart';
part 'total_value_result.g.dart';

/// Result of rolling every spot balance and futures asset into a single
/// [quoteAsset] value.
///
/// [skippedAssets] collects every asset that had a non-zero balance but
/// for which no price could be found on [quoteAsset] (neither
/// `<asset><quoteAsset>` nor `<quoteAsset><asset>`). The calculator never
/// fails the whole computation because of a single missing symbol — the UI
/// surfaces [skippedAssets] so the user knows a row wasn't priced in.
@Freezed(toJson: true, fromJson: true)
sealed class TotalValueResult with _$TotalValueResult {
  const factory TotalValueResult({
    @DecimalConverter() required Decimal total,
    required String quoteAsset,
    @Default(<String>[]) List<String> skippedAssets,
  }) = _TotalValueResult;

  factory TotalValueResult.fromJson(Map<String, dynamic> json) =>
      _$TotalValueResultFromJson(json);
}
