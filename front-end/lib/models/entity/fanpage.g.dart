// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fanpage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fanpage _$FanpageFromJson(Map<String, dynamic> json) => Fanpage(
      id: json['id'] as int?,
      fanpageName: json['fanpageName'] as String?,
      description: json['description'] as String?,
      leaderId: json['leaderId'] as int?,
      status: $enumDecodeNullable(_$FanpageStatusEnumMap, json['status']),
      createTime: Fanpage._fromJson(json['createTime'] as int?),
      subscriber: json['subscriber'] as int?,
      coverImage: json['cover_image'] as String?,
      avatarImage: json['avatar_image'] as String?,
    );

Map<String, dynamic> _$FanpageToJson(Fanpage instance) => <String, dynamic>{
      'id': instance.id,
      'fanpageName': instance.fanpageName,
      'description': instance.description,
      'leaderId': instance.leaderId,
      'status': _$FanpageStatusEnumMap[instance.status],
      'createTime': Fanpage._toJson(instance.createTime),
      'subscriber': instance.subscriber,
      'cover_image': instance.coverImage,
      'avatar_image': instance.avatarImage,
    };

const _$FanpageStatusEnumMap = {
  FanpageStatus.VERIFIED: 'VERIFIED',
  FanpageStatus.NOT_VERIFY: 'NOT_VERIFY',
};
