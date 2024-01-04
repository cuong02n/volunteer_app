import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  Role? role;
  Status? status;
  int? id;
  Gender? gender;
  String? name;
  String? email;
  String? password;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime? dob;
  String? phoneNumber;
  String? coverImage;
  String? avatarImage;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.coverImage,
    this.avatarImage,
    this.role,
    this.status,
    this.dob,
    this.phoneNumber,
    this.gender
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime? _fromJson(dynamic data) {
    if (data is int) {
      return DateTime.fromMillisecondsSinceEpoch(data);
    } else if (data is String) return DateTime.tryParse(data);
    else return null;
  }
  static int? _toJson(DateTime? time) => time?.millisecondsSinceEpoch;
}

enum Role {
  USER,
  ADMIN,
}

enum Status {
  VERIFIED,
  NOT_VERIFY,
}

enum Gender {
  UNSPECIFIED,
  MALE,
  FEMALE;
}
