import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/pages/login/set_password.dart';

import '../../configs/app_images.dart';
import '../../configs/app_logo.dart';
import '../../theme/theme.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                onPressed: () {
                  // Implement your password reset logic here
                  // Typically, you'd send a reset password email to the entered email
                  // and handle the reset process.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPScreen(),
                    ),
                  );
                },
                child: Text('Đặt lại mật khẩu'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enter the 6-digit OTP sent to your email'),
          SizedBox(
            height: 18,
          ),

          // Example: TextForm to enter OTP
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 8, 60, 8),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Nhập mã OTP'),
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ),

          // Example: Verify OTP button
          ElevatedButton(
            onPressed: () {
              // Implement your OTP verification logic here
              // Typically, you'd verify the entered OTP with the one sent to the user's email
              // and proceed accordingly.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetPasswordScreen(),
                ),
              );
            },
            child: Text('Xác nhận OTP'),
          ),
        ],
      ),
    );
  }
}
