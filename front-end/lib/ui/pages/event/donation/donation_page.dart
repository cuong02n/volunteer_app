import 'package:flutter/gestures.dart' as donation_page;
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/image_picker.dart';
import 'package:thien_nguyen_app/utilities/controllers/donation/create_donation_controller.dart';
import 'package:thien_nguyen_app/utilities/controllers/fanpage/create_fanpage_controller.dart';

part 'donation_body.dart';
part 'donation_form.dart';

class DonationPage extends Page {
  DonationPage({super.key});

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
        context: context,
        barrierColor: AppColor.white.withOpacity(0.75),
        settings: this,
        builder: (_) => const DonationBody(),
    );
  }

}