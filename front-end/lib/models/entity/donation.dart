import 'package:json_annotation/json_annotation.dart';

part 'donation.g.dart';

@JsonSerializable()
class Donation {
  int? id;
  int? userId;
  int? eventId;
  int? money;
  String? message;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime? timeStamp;

  Donation({this.id, this.userId, this.eventId, this.money, this.message, this.timeStamp});
  factory Donation.fromJson(Map<String, dynamic> json) => _$DonationFromJson(json);

  Map<String, dynamic> toJson() => _$DonationToJson(this);

  static DateTime? _fromJson(int? int) => int != null ? DateTime.fromMillisecondsSinceEpoch(int) : null;
  static int? _toJson(DateTime? time) => time?.millisecondsSinceEpoch;
}