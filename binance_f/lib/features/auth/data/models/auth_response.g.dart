// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      requiresTwoFactor: json['requiresTwoFactor'] as bool? ?? false,
      twoFactorToken: json['twoFactorToken'] as String?,
      twoFactorType: $enumDecodeNullable(
        _$TwoFactorTypeEnumMap,
        json['twoFactorType'],
      ),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'requiresTwoFactor': instance.requiresTwoFactor,
      'twoFactorToken': instance.twoFactorToken,
      'twoFactorType': _$TwoFactorTypeEnumMap[instance.twoFactorType],
    };

const _$TwoFactorTypeEnumMap = {
  TwoFactorType.totp: 'TOTP',
  TwoFactorType.sms: 'SMS',
};
