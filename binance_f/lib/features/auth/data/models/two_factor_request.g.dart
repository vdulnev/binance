// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_factor_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TwoFactorRequest _$TwoFactorRequestFromJson(Map<String, dynamic> json) =>
    _TwoFactorRequest(
      twoFactorToken: json['twoFactorToken'] as String,
      code: json['code'] as String,
      type: $enumDecode(_$TwoFactorTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TwoFactorRequestToJson(_TwoFactorRequest instance) =>
    <String, dynamic>{
      'twoFactorToken': instance.twoFactorToken,
      'code': instance.code,
      'type': _$TwoFactorTypeEnumMap[instance.type]!,
    };

const _$TwoFactorTypeEnumMap = {
  TwoFactorType.totp: 'TOTP',
  TwoFactorType.sms: 'SMS',
};
