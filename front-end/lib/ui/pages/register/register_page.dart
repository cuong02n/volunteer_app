import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/ui/app.dart';
import 'package:thien_nguyen_app/configs/assets/app_icons.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/controllers/auth/register_controller.dart';
import 'package:thien_nguyen_app/ui/widgets/app_icon.dart';

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