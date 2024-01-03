import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/controllers/otp_controller.dart';

part 'otp_body.dart';

class OtpPage extends Page {
  OtpPage({super.key});

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
      context: context,
      barrierColor: AppColor.white.withOpacity(0.75),
      settings: this,
      builder: (_) => const OtpBody(),
    );
  }

}