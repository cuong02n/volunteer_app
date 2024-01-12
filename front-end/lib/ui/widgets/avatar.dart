import 'dart:math';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback? onChangeAvatar;

  const Avatar(
      {super.key,
      required this.width,
      required this.height,
      this.onChangeAvatar});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            CircleAvatar(
              radius: min(height, width) / 2,
            ),
            Align(
                alignment: const Alignment(0.9, 0.9),
                child: IconButton(
                    onPressed: onChangeAvatar ?? () {}, icon: Icon(Icons.camera_alt)))
          ],
        ));
  }
}
