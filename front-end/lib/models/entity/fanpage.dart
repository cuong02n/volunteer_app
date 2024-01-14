import 'package:json_annotation/json_annotation.dart';

part 'fanpage.g.dart';

@JsonSerializable()
class Fanpage {
  int? id;
  String? fanpageName;
  String? description;
  int? leaderId;
  FanpageStatus? status;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime? createTime;
  int? subscriber;
  @JsonKey(name: 'cover_image')
  String? coverImage;
  @JsonKey(name: 'avatar_image')
  String? avatarImage;

  Fanpage({this.id, this.fanpageName, this.description, this.leaderId, this.status, this.createTime, this.subscriber, this.coverImage, this.avatarImage});
  factory Fanpage.fromJson(Map<String, dynamic> json) => _$FanpageFromJson(json);

  Map<String, dynamic> toJson() => _$FanpageToJson(this);

  static DateTime? _fromJson(int? int) => int != null ? DateTime.fromMillisecondsSinceEpoch(int) : null;
  static int? _toJson(DateTime? time) => time?.millisecondsSinceEpoch;
}

enum FanpageStatus {
  VERIFIED,
  NOT_VERIFY,
}
