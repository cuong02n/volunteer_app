import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:thien_nguyen_app/repositories/server/fanpage_provider.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/avatar.dart';
import 'package:thien_nguyen_app/ui/widgets/background_image.dart';
import 'package:thien_nguyen_app/ui/widgets/status_widget.dart';

part 'child_page_body.dart';

part 'child_page_status_list.dart';

class ChildPagePage extends StatelessWidget {
  final int id;

  const ChildPagePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.white10,
        ),
        extendBodyBehindAppBar: true,
        body: FutureBuilder(
            future: FanpageServerRepository.getFanpage(id),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ChildPageBody(fanpage: snapshot.requireData),
                    ),
                    ChildPageStatusList()
                  ],
                );
              else if (snapshot.hasError)
                return Center(
                  child: Icon(Icons.report),
                );
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }));
  }
}
