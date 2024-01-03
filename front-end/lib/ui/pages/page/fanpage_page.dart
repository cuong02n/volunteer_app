import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/fanpage_choice.dart';

part 'fanpage_page_appbar.dart';

class FanpagePage extends StatelessWidget {
  const FanpagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        FanpagePageAppBar(),
        SliverAnimatedList(
            initialItemCount: 100,
            itemBuilder: (context, index, animation) => FanpageChoice()
        )
      ],
    );
  }
}
