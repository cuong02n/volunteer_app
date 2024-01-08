import 'package:json_annotation/json_annotation.dart';

part 'criteria_event.g.dart';

@JsonSerializable(includeIfNull: false)
class EventCriteria {
  int? id;
  String? title;
  String? content;
  int? progress;
  int? target;
  @JsonKey(fromJson: _fromJson, toJson: _toJson, name: 'start_time')
  DateTime? startTime;
  @JsonKey(fromJson: _fromJson, toJson: _toJson, name: 'end_time')
  DateTime? endTime;
  @JsonKey(name: 'fanpage_id')
  int? fanpageId;
  EventStatus? status;
  @JsonKey(name: 'min_target')
  int? minTarget;
  @JsonKey(name: 'max_target')
  int? maxTarget;

  EventCriteria({this.id, this.title, this.content, this.progress, this.target, this.startTime, this.endTime, this.fanpageId, this.status, this.minTarget, this.maxTarget});
  factory EventCriteria.fromJson(Map<String, dynamic> json) => _$EventCriteriaFromJson(json);

  Map<String, dynamic> toJson() => _$EventCriteriaToJson(this);

  static DateTime? _fromJson(int? int) => int != null ? DateTime.fromMillisecondsSinceEpoch(int) : null;
  static int? _toJson(DateTime? time) => time?.millisecondsSinceEpoch;
}

enum EventStatus {
  VERIFIED,
  NOT_VERIFY,
}
