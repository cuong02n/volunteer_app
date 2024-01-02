import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/configs/assets/app_logo.dart';
import 'package:thien_nguyen_app/pages/forget_password/set_password.dart';

import '../../theme/theme.dart';
import '../otp/otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.h), // Set the height of your image
        child: AppBar(
          flexibleSpace: Image.asset(AppImages.background,
              width: 100.w, height: 35.h, fit: BoxFit.fill),

          // Add other properties as needed
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "ThienNguyen",
                  style: AppTypology.appName,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your forgot password widgets go here
              Text('Nhập email của bạn để đặt lại mật khẩu'),

              // Example: TextForm to enter email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),

              // Example: Reset Password button
              ElevatedButton(
                onPressed: _verifyEmail,
                child: Text('Đặt lại mật khẩu'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _verifyEmail() async {
    //TODO: call API
  }
}
