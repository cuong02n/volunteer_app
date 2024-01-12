import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

class AvatarRequest {
  MultipartFile? image;

  AvatarRequest({this.image});
}