import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/theme/theme.dart';

part 'edit_user_body.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({super.key});

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
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(child: EditUserBody()),
            Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: FilledButton(onPressed: _confirm, child: Center(child: Text("Cập nhật"),)))
          ],
        ));
  }

  void _confirm() {
  }
}
