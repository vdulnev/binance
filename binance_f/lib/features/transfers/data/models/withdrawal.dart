import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/serialization/decimal_converter.dart';

part 'withdrawal.freezed.dart';
part 'withdrawal.g.dart';

/// A single withdrawal record from
/// `GET /sapi/v1/capital/withdraw/history` (Phase 10 — FR-8.1).
@Freezed(toJson: false, fromJson: true)
sealed class Withdrawal with _$Withdrawal {
  const Withdrawal._();

  const factory Withdrawal({
    required String id,
    @DecimalConverter() required Decimal amount,
    @DecimalConverter() required Decimal transactionFee,
    required String coin,
    required String network,
    /// 0: email sent, 1: cancelled, 2: awaiting approval,
    /// 3: rejected, 4: processing, 5: failure, 6: completed
    required int status,
    required String address,
    String? addressTag,
    required String txId,
    required String applyTime,
  }) = _Withdrawal;

  factory Withdrawal.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalFromJson(json);

  DateTime get applyDateTime => DateTime.parse(applyTime);

  String get statusLabel => switch (status) {
    0 => 'Email Sent',
    1 => 'Cancelled',
    2 => 'Awaiting Approval',
    3 => 'Rejected',
    4 => 'Processing',
    5 => 'Failure',
    6 => 'Completed',
    _ => 'Unknown ($status)',
  };
}
