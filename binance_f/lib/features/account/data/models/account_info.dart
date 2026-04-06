import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_info.freezed.dart';
part 'account_info.g.dart';

@freezed
abstract class AccountInfo with _$AccountInfo {
  const factory AccountInfo({
    required int uid,
    required String accountType,
    required bool canTrade,
    required bool canWithdraw,
    required bool canDeposit,
    required List<Balance> balances,
    required CommissionRates commissionRates,
  }) = _AccountInfo;

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);
}

@freezed
abstract class Balance with _$Balance {
  const factory Balance({
    required String asset,
    required String free,
    required String locked,
  }) = _Balance;

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);
}

@freezed
abstract class CommissionRates with _$CommissionRates {
  const factory CommissionRates({
    required String maker,
    required String taker,
    required String buyer,
    required String seller,
  }) = _CommissionRates;

  factory CommissionRates.fromJson(Map<String, dynamic> json) =>
      _$CommissionRatesFromJson(json);
}
