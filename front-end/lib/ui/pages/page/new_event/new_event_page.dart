import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/models/entity/bank.dart';
import 'package:thien_nguyen_app/repositories/server/bank_provider.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/image_picker.dart';
import 'package:thien_nguyen_app/utilities/bloc/fanpage_cubit.dart';
import 'package:thien_nguyen_app/utilities/controllers/event/create_event_controller.dart';
import 'package:thien_nguyen_app/utilities/controllers/fanpage/create_fanpage_controller.dart';

part 'new_event_body.dart';
part 'new_event_page_component.dart';

class NewEventPage extends Page {
  final int fanpageId;
  const NewEventPage({super.key, required this.fanpageId});

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
        context: context,
        barrierColor: AppColor.white.withOpacity(0.75),
        settings: this,
        builder: (_) => BlocProvider(
            create: (_) => FanpageCubit(fanpageId),
            child: const NewEventBody()),
    );
  }

}