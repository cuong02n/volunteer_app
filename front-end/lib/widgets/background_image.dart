import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';

class BackgroundImage extends StatelessWidget {
  final double? height;
  final VoidCallback? changePhoto;

  const BackgroundImage({super.key, this.height, this.changePhoto});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 30.h,
      alignment: Alignment.bottomRight,
      decoration: BoxDecoration(
        color: AppColor.orange,
      ),
      child: IconButton(
        icon: Icon(Icons.camera_alt, color: AppColor.grey),
        onPressed: changePhoto ?? () {},
      ),
    );
  }

}