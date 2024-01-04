import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_avatar.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/providers/user_avatar_provider.dart';

class UserAvatar extends StatelessWidget {
  final IUserAvatar provider;

  final double radius;
  final double _diameter;
  final bool isCollapsed;

  const UserAvatar({super.key, this.radius = 50, required this.provider})
      : _diameter = radius * 2, isCollapsed = false;
  
  const UserAvatar.collapsed({super.key, this.radius = 50, required this.provider}) : _diameter = radius * 2, isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: _diameter,
          height: _diameter,
          child: CachedNetworkImage(
            imageUrl: provider.avatarUrl ?? "",
            imageBuilder: (context, imageProvider) => DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            progressIndicatorBuilder: (context, _, progress) =>
                CircularProgressIndicator(value: progress.progress),
            errorWidget: (context, _, error) => DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: provider.defaultAvatar, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(provider.name, style: AppTypology.titleMedium),
        ),
      ].sublist(0, isCollapsed? 1: 2),
    );
  }
}
