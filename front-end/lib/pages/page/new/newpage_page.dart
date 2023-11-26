import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/image_picker.dart';

part 'newpage_body.dart';
part 'newpage_page_component.dart';

class NewPagePage extends Page {
  NewPagePage({super.key});

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
        context: context,
        barrierColor: AppColor.white.withOpacity(0.75),
        settings: this,
        builder: (_) => const NewPageBody(),
    );
  }

}