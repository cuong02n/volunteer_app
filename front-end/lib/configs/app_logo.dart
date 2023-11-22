import 'package:flutter/material.dart';

///Logo app
class AppLogo extends StatelessWidget {
  late final Size size;

  static const _origin = 'assets/logo/origin.png';

  AppLogo({super.key, Size? rectSize, double size = 50})
      {
    this.size = rectSize ?? Size(size, size);
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(_origin,
        width: size.width, height: size.height, fit: BoxFit.fill);
  }
}
