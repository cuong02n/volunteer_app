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

  double get process {
    if (progress == null || target == null) {
      return 0;
    } else {
      return (progress! / target!).clamp(0, 1);
    }
  }

  String? qrCode(int userId) => Uri.https('img.vietqr.io', '/image/$bank-$bankAccount-compact2.png', {
    'addInfo': "Ung ho chien dich $id id $userId"
  }).toString();
}

enum EventStatus {
  VERIFIED,
  NOT_VERIFY,
}
