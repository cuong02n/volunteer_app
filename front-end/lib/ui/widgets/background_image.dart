import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_cover.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/controllers/files/image_picker_controller.dart';

class BackgroundImage extends StatefulWidget {
  final double? height;
  final bool canEdit;
  final IUserCover provider;

  const BackgroundImage({super.key, this.height, this.canEdit = false, required this.provider});

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
        SizedBox(
        width: double.infinity,
        height: widget.height ?? 30.h,
        child: CachedNetworkImage(
          imageUrl: widget.provider.coverUrl ?? "",
          imageBuilder: (context, imageProvider) => DecoratedBox(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide()),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          progressIndicatorBuilder: (context, _, progress) =>
              CircularProgressIndicator(value: progress.progress),
          errorWidget: (context, _, error) => DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: widget.provider.defaultCover, fit: BoxFit.cover),
            ),
          ),
        )),
    SizedBox(
    width: double.infinity,
    height: widget.height ?? 30.h,
    child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: _edit,
            icon: Icon(Icons.camera_alt),
          ),
        ))
        ].sublist(0, (widget.canEdit)? 2: 1)
    );
  }

  void _edit() async {
    var coverPickerController = ImagePickerController();
    try {
      XFile? newCover = await coverPickerController.pickImage();
      if (newCover == null) return;
      await UserServerRepository.uploadCover(newCover);
      setState(() {});
    }
    catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}