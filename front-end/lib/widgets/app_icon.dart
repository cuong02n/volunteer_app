import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final String path;
  final double size;

  const AppIcon(this.path, {super.key, this.size = 25});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5), child: Image.asset(
      path,
      width: size,
      height: size,
      fit: BoxFit.fitWidth,
    ),);
  }
}