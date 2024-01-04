import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/avatar.dart';
import 'package:thien_nguyen_app/ui/widgets/background_image.dart';
import 'package:thien_nguyen_app/ui/widgets/status_widget.dart';

part 'user_page_body.dart';
part 'user_page_status_list.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

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
            child: UserPageBody(),
          ),
          UserPageStatusList()
        ],
      )
    );
  }
}