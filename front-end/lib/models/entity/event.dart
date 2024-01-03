import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  int? id;
  String? title;
  String? content;
  int? progress;
  int? target;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime? startTime;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime? endTime;
  int? fanpageId;
  EventStatus? status;
  String? image;
  String? bank;
  String? bankAccount;

  Event({this.id, this.title, this.content, this.progress, this.target, this.startTime, this.endTime, this.fanpageId, this.status, this.image, this.bank, this.bankAccount});
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  static DateTime? _fromJson(int? int) => int != null ? DateTime.fromMillisecondsSinceEpoch(int) : null;
  static int? _toJson(DateTime? time) => time?.millisecondsSinceEpoch;
}

enum EventStatus {
  VERIFIED,
  NOT_VERIFY,
}
