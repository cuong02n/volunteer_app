import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_avatar.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_cover.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:thien_nguyen_app/models/entity/user.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';

class FanpageImageProvider implements IUserAvatar, IUserCover {
  final Fanpage fanpage;
  FanpageImageProvider({required this.fanpage});

  @override
  String? get avatarUrl => fanpage.avatarImage;

  @override
  ImageProvider defaultAvatar = const AssetImage(AppImages.defaultUserAvatar);

  @override
  String get name => fanpage.fanpageName!;

  @override
  ImageProvider<Object> defaultCover = const AssetImage(AppImages.background);

  @override
  String? get coverUrl => fanpage.coverImage;

  dynamic get coverProvider {
    if (coverUrl != null) return CachedNetworkImageProvider(coverUrl!);
    else return defaultCover;
  }
}