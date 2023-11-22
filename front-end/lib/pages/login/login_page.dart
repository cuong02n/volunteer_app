import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/app_icons.dart';
import 'package:thien_nguyen_app/configs/app_images.dart';
import 'package:thien_nguyen_app/configs/app_logo.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/app_icon.dart';

part 'login_page_body.dart';
part 'login_page_components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: LoginPageBody(),
      ),
    );
  }
}