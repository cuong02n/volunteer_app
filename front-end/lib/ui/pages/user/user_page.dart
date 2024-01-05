import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_avatar.dart';
import 'package:thien_nguyen_app/interface/ui/i_user_cover.dart';
import 'package:thien_nguyen_app/models/entity/user.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/avatar.dart';
import 'package:thien_nguyen_app/ui/widgets/background_image.dart';
import 'package:thien_nguyen_app/ui/widgets/status_widget.dart';
import 'package:thien_nguyen_app/ui/widgets/user_avatar.dart';
import 'package:thien_nguyen_app/utilities/bloc/edit_controller_bloc.dart';
import 'package:thien_nguyen_app/utilities/providers/user_avatar_provider.dart';
import 'package:thien_nguyen_app/utilities/providers/user_cover_provider.dart';

part 'user_page_body.dart';
part 'user_page_status_list.dart';

class UserPage extends StatelessWidget {
  final int id;
  UserPage({super.key, required this.id});
  final EditUserBloc _bloc = EditUserBloc(null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: UserPageBody(id: id,),
            ),
            UserPageStatusList()
          ],
        )
      ),
    );
  }
}