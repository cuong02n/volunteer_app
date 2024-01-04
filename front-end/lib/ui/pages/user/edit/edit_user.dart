import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/models/entity/user.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/user_avatar.dart';
import 'package:thien_nguyen_app/utilities/bloc/edit_controller_bloc.dart';
import 'package:thien_nguyen_app/utilities/controllers/user/edit_user_controller.dart';

part 'edit_user_body.dart';

class EditUserPage extends StatelessWidget {
  final _bloc = EditUserBloc(null);
  EditUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
          appBar: AppBar(
              leading: BackButton(
                onPressed: () => context.pop(_bloc.state?.edited ?? false),
              ),
              backgroundColor: Colors.transparent,
              title: Text(
                "Chỉnh sửa thông tin cá nhân",
                style: AppTypology.titleSmall,
              )),
          extendBody: true,
          body: Builder(
            builder: (context) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(child: EditUserBody()),
                  Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FilledButton(onPressed: _confirm(context), child: Center(child: Text("Cập nhật"),)))
                ],
              );
            }
          )),
    );
  }

  VoidCallback _confirm(BuildContext context) {
    return () {
      context.read<EditUserBloc>().state?.confirm();
    };
  }
}
