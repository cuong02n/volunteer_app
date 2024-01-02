import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  String? name;
  String? email;
  String? password;

  RegisterRequest({this.name, this.email, this.password});

  factory RegisterRequest.fromJson(Map<String, dynamic> data) => _$RegisterRequestFromJson(data);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}