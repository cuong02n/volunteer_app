import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_cover.dart';
import 'package:thien_nguyen_app/models/entity/user.dart';

class UserCoverProvider implements IUserCover {
  final User user;
  UserCoverProvider({required this.user});

  @override
  String? get coverUrl => user.coverImage;

  @override
  ImageProvider defaultCover = const AssetImage(AppImages.background);
}