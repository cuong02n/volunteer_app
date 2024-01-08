// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      bin: json['bin'] as String?,
      shortName: json['shortName'] as String?,
      transferSupported: json['transferSupported'] as int?,
      lookupSupported: json['lookupSupported'] as int?,
    )..logo = json['logo'] as String?;

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'bin': instance.bin,
      'shortName': instance.shortName,
      'logo': instance.logo,
      'transferSupported': instance.transferSupported,
      'lookupSupported': instance.lookupSupported,
    };
