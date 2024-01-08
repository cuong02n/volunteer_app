// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCriteria _$EventCriteriaFromJson(Map<String, dynamic> json) =>
    EventCriteria(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      progress: json['progress'] as int?,
      target: json['target'] as int?,
      startTime: EventCriteria._fromJson(json['start_time'] as int?),
      endTime: EventCriteria._fromJson(json['end_time'] as int?),
      fanpageId: json['fanpage_id'] as int?,
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']),
      minTarget: json['min_target'] as int?,
      maxTarget: json['max_target'] as int?,
    );

Map<String, dynamic> _$EventCriteriaToJson(EventCriteria instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  writeNotNull('progress', instance.progress);
  writeNotNull('target', instance.target);
  writeNotNull('start_time', EventCriteria._toJson(instance.startTime));
  writeNotNull('end_time', EventCriteria._toJson(instance.endTime));
  writeNotNull('fanpage_id', instance.fanpageId);
  writeNotNull('status', _$EventStatusEnumMap[instance.status]);
  writeNotNull('min_target', instance.minTarget);
  writeNotNull('max_target', instance.maxTarget);
  return val;
}

const _$EventStatusEnumMap = {
  EventStatus.VERIFIED: 'VERIFIED',
  EventStatus.NOT_VERIFY: 'NOT_VERIFY',
};
