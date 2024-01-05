import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

abstract interface class IUserCover {
  String? get coverUrl;
  late final ImageProvider defaultCover;
}