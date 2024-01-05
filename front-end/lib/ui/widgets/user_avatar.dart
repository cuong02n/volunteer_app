import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_avatar.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/bloc/edit_controller_bloc.dart';
import 'package:thien_nguyen_app/utilities/controllers/user/edit_user_controller.dart';
import 'package:thien_nguyen_app/utilities/providers/user_avatar_provider.dart';

class UserAvatar extends StatefulWidget {
  final IUserAvatar provider;

  final double radius;
  final double _diameter;
  final bool isCollapsed;
  final bool canEdit;

  const UserAvatar({super.key, this.radius = 50, required this.provider, this.canEdit = false})
      : _diameter = radius * 2, isCollapsed = false;
  
  const UserAvatar.collapsed({super.key, this.radius = 50, required this.provider, this.canEdit = false}) : _diameter = radius * 2, isCollapsed = true;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  EditUserController? _controller;
  late IUserAvatar _provider;

  @override
  void initState() {
    super.initState();
    _provider = widget.provider;
    if (widget.canEdit) {
      _controller = EditUserController(context);
      _controller?.init();
      context.read<EditUserBloc>().emit(_controller);
      _controller?.addListener(() {setState(() {
      });});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: widget._diameter,
              height: widget._diameter,
              child: CachedNetworkImage(
                imageUrl: _provider.avatarUrl ?? "",
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
                        image: widget.provider.defaultAvatar, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(widget.provider.name, style: AppTypology.titleMedium),
            ),
          ].sublist(0, widget.isCollapsed? 1: 2),
        ),
        Container(
            width: widget._diameter,
            height: widget._diameter,
            alignment: const Alignment(0.9, 0.9),
            child: IconButton(
                onPressed: _controller?.changeAvatar, icon: Icon(Icons.camera_alt)))
      ].sublist(0, (widget.canEdit) ? 2: 1),
    );
  }
}
