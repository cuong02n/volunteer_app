import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_avatar.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/bloc/edit_controller_bloc.dart';
import 'package:thien_nguyen_app/utilities/controllers/user/edit_user_controller.dart';
import 'package:thien_nguyen_app/utilities/providers/user_avatar_provider.dart';

class FanpageAvatar extends StatefulWidget {
  final IUserAvatar provider;

  final double radius;
  final double _diameter;

  const FanpageAvatar({super.key, this.radius = 50, required this.provider}) : _diameter = radius * 2;

  @override
  State<FanpageAvatar> createState() => _FanpageAvatarState();
}

class _FanpageAvatarState extends State<FanpageAvatar> {
  late IUserAvatar _provider;

  @override
  void initState() {
    super.initState();
    _provider = widget.provider;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: widget._diameter,
              height: widget._diameter,
              child: CachedNetworkImage(
                imageUrl: _provider.avatarUrl ?? "",
                imageBuilder: (context, imageProvider) => DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.orange, width: 4),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, _, error) => DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: widget.provider.defaultAvatar, fit: BoxFit.cover),
                  ),
                ),
              ),
            );
  }
}
