// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      coverImage: json['coverImage'] as String?,
      avatarImage: json['avatarImage'] as String?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'role': _$RoleEnumMap[instance.role],
      'status': _$StatusEnumMap[instance.status],
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'coverImage': instance.coverImage,
      'avatarImage': instance.avatarImage,
    };

const _$RoleEnumMap = {
  Role.USER: 'USER',
  Role.ADMIN: 'ADMIN',
};

const _$StatusEnumMap = {
  Status.VERIFIED: 'VERIFIED',
  Status.NOT_VERIFY: 'NOT_VERIFY',
};
