import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'deposit.freezed.dart';
part 'deposit.g.dart';

/// A single deposit record from `GET /sapi/v1/capital/deposit/hisrec`
/// (Phase 10 — FR-8.1).
@Freezed(toJson: false, fromJson: true)
sealed class Deposit with _$Deposit {
  const Deposit._();

  const factory Deposit({
    required String id,
    @DecimalConverter() required Decimal amount,
    required String coin,
    required String network,

    /// 0: pending, 6: credited, 1: success
    required int status,
    required String address,
    String? addressTag,
    required String txId,
    required int insertTime,
    int? confirmTimes,
    int? unlockConfirm,
  }) = _Deposit;

  factory Deposit.fromJson(Map<String, dynamic> json) =>
      _$DepositFromJson(json);

  DateTime get insertDateTime =>
      DateTime.fromMillisecondsSinceEpoch(insertTime);

  String get statusLabel => switch (status) {
    0 => 'Pending',
    6 => 'Credited',
    1 => 'Success',
    _ => 'Unknown ($status)',
  };
}
