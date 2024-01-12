// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      progress: json['progress'] as int?,
      target: json['target'] as int?,
      startTime: Event._fromJson(json['startTime'] as int?),
      endTime: Event._fromJson(json['endTime'] as int?),
      fanpageId: json['fanpageId'] as int?,
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']),
      image: json['image'] as String?,
      bank: json['bank'] as String?,
      bankAccount: json['bankAccount'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'progress': instance.progress,
      'target': instance.target,
      'startTime': Event._toJson(instance.startTime),
      'endTime': Event._toJson(instance.endTime),
      'fanpageId': instance.fanpageId,
      'status': _$EventStatusEnumMap[instance.status],
      'image': instance.image,
      'bank': instance.bank,
      'bankAccount': instance.bankAccount,
    };

const _$EventStatusEnumMap = {
  EventStatus.VERIFIED: 'VERIFIED',
  EventStatus.NOT_VERIFY: 'NOT_VERIFY',
};
