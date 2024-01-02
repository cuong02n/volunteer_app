import 'package:flutter/material.dart';
import 'package:thien_nguyen_app/pages/forget_password/set_password.dart';

class ForgetOtpPage extends StatefulWidget {
  const ForgetOtpPage({super.key});

  @override
  State<ForgetOtpPage> createState() => _ForgetOtpPageState();
}

class _ForgetOtpPageState extends State<ForgetOtpPage> {
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
            onPressed: _resetPassword,
            child: Text('Xác nhận OTP'),
          ),
        ],
      ),
    );
  }

  void _resetPassword() async {
    // Implement your OTP verification logic here
    // Typically, you'd verify the entered OTP with the one sent to the user's email
    // and proceed accordingly.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordPage(),
      ),
    );
  }
}