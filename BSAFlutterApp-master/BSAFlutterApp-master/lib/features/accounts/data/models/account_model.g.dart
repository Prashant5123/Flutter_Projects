// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountModelImpl _$$AccountModelImplFromJson(Map<String, dynamic> json) =>
    _$AccountModelImpl(
      badId: (json['badId'] as num).toInt(),
      accountName: json['accountName'] as String,
      accountNumber: json['accountNumber'] as String,
      bankName: json['bankName'] as String,
      accountType: json['accountType'] as String,
      progress: _progressFromJson(json['progress']),
    );

Map<String, dynamic> _$$AccountModelImplToJson(_$AccountModelImpl instance) =>
    <String, dynamic>{
      'badId': instance.badId,
      'accountName': instance.accountName,
      'accountNumber': instance.accountNumber,
      'bankName': instance.bankName,
      'accountType': instance.accountType,
      'progress': instance.progress,
    };
