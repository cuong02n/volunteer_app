import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/avatar.dart';
import 'package:thien_nguyen_app/widgets/background_image.dart';
import 'package:thien_nguyen_app/widgets/status_widget.dart';

part 'child_page_body.dart';
part 'child_page_status_list.dart';

class ChildPagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.white10,
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ChildPageBody(),
          ),
          ChildPageStatusList()
        ],
      )
    );
  }
}