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
      dob: User._fromJson(json['dob']),
      phoneNumber: json['phoneNumber'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'role': _$RoleEnumMap[instance.role],
      'status': _$StatusEnumMap[instance.status],
      'id': instance.id,
      'gender': _$GenderEnumMap[instance.gender],
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'dob': User._toJson(instance.dob),
      'phoneNumber': instance.phoneNumber,
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

const _$GenderEnumMap = {
  Gender.UNSPECIFIED: 'UNSPECIFIED',
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
};
