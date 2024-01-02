import 'package:json_annotation/json_annotation.dart';

part 'otp_request.g.dart';

@JsonSerializable()
class OtpRequest {
  String? email;
  String? otp;

  OtpRequest({this.email, this.otp});

  factory OtpRequest.fromJson(Map<String, dynamic> data) => _$OtpRequestFromJson(data);

  Map<String, dynamic> toJson() => _$OtpRequestToJson(this);
}