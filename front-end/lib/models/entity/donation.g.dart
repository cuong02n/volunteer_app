// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Donation _$DonationFromJson(Map<String, dynamic> json) => Donation(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      eventId: json['eventId'] as int?,
      money: json['money'] as int?,
      message: json['message'] as String?,
      timeStamp: Donation._fromJson(json['timeStamp'] as int?),
    );

Map<String, dynamic> _$DonationToJson(Donation instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'eventId': instance.eventId,
      'money': instance.money,
      'message': instance.message,
      'timeStamp': Donation._toJson(instance.timeStamp),
    };
