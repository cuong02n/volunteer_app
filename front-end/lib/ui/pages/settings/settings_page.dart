import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_icons.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/app_icon.dart';
import 'package:thien_nguyen_app/ui/widgets/navigation_button.dart';
import 'package:thien_nguyen_app/ui/widgets/user_avatar.dart';
import 'package:thien_nguyen_app/utilities/bloc/edit_controller_bloc.dart';
import 'package:thien_nguyen_app/utilities/providers/user_avatar_provider.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final currentUser = CurrentUserAvatarProvider();

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return BlocProvider(
      create: (_) => EditUserBloc(null),
      child: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  UserAvatar(provider: currentUser),
                  NavigationButton(
                      icon: AppIcon(AppIcons.user),
                      title: "Trang cá nhân",
                      onPressed: _showProfile),
                  NavigationButton(
                      icon: AppIcon(AppIcons.edit),
                      title: "Chỉnh sửa thông tin cá nhân",
                      onPressed: _editProfile),
                  NavigationButton(
                      icon: AppIcon(AppIcons.config),
                      title: "Cài đặt tài khoản",
                      onPressed: _accountSettings),
                  NavigationButton(
                      icon: AppIcon(AppIcons.headset),
                      title: "Trợ giúp",
                      onPressed: _help),
                  NavigationButton(
                      icon: AppIcon(AppIcons.doc),
                      title: "Điều khoản sử dụng",
                      onPressed: _showTerms),
                  NavigationButton(
                      icon: AppIcon(AppIcons.lock),
                      title: "Chính sách bảo mật",
                      onPressed: _showPolicy),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void _showProfile() {
    _context.pushNamed(RouteName.user);
  }

  void _editProfile() async {
    bool result = await context.push("/user/edit") as bool;
    print(result);
    if (result) setState(() {});
  }

  void _accountSettings() {
    _context.pushNamed(RouteName.account);
  }

  void _help() {
    _context.pushNamed(RouteName.helpAndSupport);
  }

  void _showTerms() {
    _context.pushNamed(RouteName.terms);
  }

  void _showPolicy() {
    _context.pushNamed(RouteName.privacyPolicy);
  }
}
