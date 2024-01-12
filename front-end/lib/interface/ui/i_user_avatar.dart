import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

abstract interface class IUserAvatar {
  String? get avatarUrl;
  late final ImageProvider defaultAvatar;
  String get name;
}