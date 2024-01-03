import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  Role? role;
  Status? status;
  int? id;
  String? name;
  String? email;
  String? password;
  String? coverImage;
  String? avatarImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.coverImage,
    required this.avatarImage,
    required this.role,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum Role {
  USER,
  ADMIN,
}

enum Status {
  VERIFIED,
  NOT_VERIFY,
}
