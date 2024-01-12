import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  String? email;
  String? newPassword;
  String? otp;

  ResetPasswordRequest({this.email, this.newPassword, this.otp}) ;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> data) => _$ResetPasswordRequestFromJson(data);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}