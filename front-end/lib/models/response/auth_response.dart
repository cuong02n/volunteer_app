import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  String? token;
  int? userId;

  AuthResponse({this.token, this.userId});

  factory AuthResponse.fromJson(Map<String, dynamic> data) => _$AuthResponseFromJson(data);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}