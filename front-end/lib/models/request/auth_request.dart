import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  String? email;
  String? password;

  AuthRequest({this.email, this.password});

  factory AuthRequest.fromJson(Map<String, dynamic> data) => _$AuthRequestFromJson(data);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}