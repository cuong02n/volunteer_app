import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  late final Widget child;
  final double? width;
  final double? height;

  ImagePreview.fromPath(String path, {super.key, this.width, this.height}) {
    if (kIsWeb) {
      child = Image.network(path);
    }
    else {
      child = Image.file(File(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
    );
  }
}