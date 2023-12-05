// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/theme/theme.dart';
import 'package:thien_nguyen_app/widgets/navigation_button.dart';

part 'account_page_body.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Chỉnh sửa thông tin cá nhân",
              style: AppTypology.titleSmall,
            )),
        extendBody: true,
        body:
            SingleChildScrollView(child: AccountPageBody()),
            );
  }

}
