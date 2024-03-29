import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/app.dart';
import 'package:thien_nguyen_app/configs/app_icons.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/app_icon.dart';

part 'register_body.dart';
part 'register_page_component.dart';

class RegisterPage extends Page {
  RegisterPage({super.key});

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
        context: context,
        barrierColor: AppColor.white.withOpacity(0.75),
        settings: this,
        builder: (_) => const RegisterBody(),
    );
  }

}