import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_icons.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/app_icon.dart';
import 'package:thien_nguyen_app/widgets/navigation_button.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            CircleAvatar(radius: 15.w, foregroundColor: Colors.blue,),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("User Name", style: AppTypology.titleMedium),
            ),
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

  void _showProfile() {
    _context.pushNamed(RouteName.user);
  }

  void _editProfile() {
    _context.push("/user/edit");
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
