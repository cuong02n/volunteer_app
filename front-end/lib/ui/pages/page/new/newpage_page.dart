import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/image_picker.dart';
import 'package:thien_nguyen_app/utilities/controllers/fanpage/edit_fanpage_controller.dart';

part 'newpage_body.dart';
part 'newpage_page_component.dart';

class NewPagePage extends Page {
  Fanpage? fanpage;
  NewPagePage({super.key, this.fanpage});

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
        context: context,
        barrierColor: AppColor.white.withOpacity(0.75),
        settings: this,
        builder: (_) => NewPageBody(fanpage: fanpage),
    );
  }

}