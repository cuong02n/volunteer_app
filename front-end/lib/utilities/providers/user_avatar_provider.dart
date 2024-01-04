import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_avatar.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';

class CurrentUserAvatarProvider implements IUserAvatar {
  @override
  String? get avatarUrl => CurrentInfo.user!.avatarImage;

  @override
  ImageProvider defaultAvatar = const AssetImage(AppImages.defaultUserAvatar);

  @override
  String get name => CurrentInfo.user!.name!;
}