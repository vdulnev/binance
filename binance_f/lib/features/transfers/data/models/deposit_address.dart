import 'package:freezed_annotation/freezed_annotation.dart';

part 'deposit_address.freezed.dart';
part 'deposit_address.g.dart';

/// A deposit address from `GET /sapi/v1/capital/deposit/address`
/// (Phase 10 — FR-8.1).
@Freezed(toJson: false, fromJson: true)
sealed class DepositAddress with _$DepositAddress {
  const factory DepositAddress({
    required String coin,
    required String address,
    String? tag,
    required String url,
  }) = _DepositAddress;

  factory DepositAddress.fromJson(Map<String, dynamic> json) =>
      _$DepositAddressFromJson(json);
}
