import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/configs/assets/app_images.dart';
import 'package:thien_nguyen_app/configs/assets/app_logo.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/utilities/controllers/reset_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final ResetPasswordController _controller;

  List<Widget> get expand => (!_controller.isExpanded)? [
    ElevatedButton(
    onPressed: _controller.checkExists,
    child: Text('Kiểm tra'),
  )] : [
    const SizedBox(height: 10),
    TextFormField(
      autofillHints: const [AutofillHints.newPassword],
      controller: _controller.passwordController,
      focusNode: _controller.passwordNode,
      onTap: () => _controller.passwordNode.requestFocus(),
      onTapOutside: (_) => _controller.passwordNode.unfocus(),
      onFieldSubmitted: (_) => _controller.nextFocus(),
      obscureText: !_controller.isShowPassword,
      decoration: InputDecoration(
          errorText: _controller.passwordError,
          suffixIcon: IconButton(
              icon: Icon((_controller.isShowPassword)? Icons.visibility_off: Icons.visibility),
              onPressed: _controller.setPasswordShow),
          labelText: "Nhập mật khẩu"),
    ),
    const SizedBox(height: 10),
    TextFormField(
      controller: _controller.retypePasswordController,
      focusNode: _controller.retypePasswordNode,
      onTap: () => _controller.retypePasswordNode.requestFocus(),
      onTapOutside: (_) => _controller.retypePasswordNode.unfocus(),
      onFieldSubmitted: (_) => _controller.nextFocus(),
      obscureText: !_controller.isShowRetypePassword,
      decoration: InputDecoration(
          errorText: _controller.retypePasswordError,
          suffixIcon: IconButton(
              icon: Icon((_controller.isShowRetypePassword)? Icons.visibility_off: Icons.visibility),
              onPressed: _controller.setRetypePasswordShow),
          labelText: "Nhập lại mật khẩu"),
    ),
    const SizedBox(height: 10),
    Text("Mã OTP đã gửi vào hòm thư của bạn"),
    TextFormField(
      autofillHints: const [AutofillHints.oneTimeCode],
      controller: _controller.otpController,
      focusNode: _controller.otpNode,
      onTap: () => _controller.otpNode.requestFocus(),
      onTapOutside: (_) => _controller.otpNode.unfocus(),
      onFieldSubmitted: (_) => _controller.nextFocus(),
      obscureText: !_controller.isShowOtp,
      decoration: InputDecoration(
          errorText: _controller.otpError,
          suffixIcon: IconButton(
              icon: Icon((_controller.isShowOtp)? Icons.visibility_off: Icons.visibility),
              onPressed: _controller.setOtpShow),
          labelText: "Nhập OTP"),
    ),
    ElevatedButton(
      onPressed: _controller.resetPassword,
      child: Text('Đặt lại mật khẩu'),
    )
  ];

  @override
  void initState() {
    super.initState();
    _controller = ResetPasswordController(context);
    _controller.init();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AutofillGroup(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Your forgot password widgets go here
                      Text((!_controller.isExpanded)? 'Nhập email của bạn để đặt lại mật khẩu': 'Nhập mật khẩu mới của bạn'),
                      // Example: TextForm to enter email
                      const SizedBox(height: 5),
                      TextFormField(
                        autofillHints: const [AutofillHints.email],
                        controller: _controller.usernameController,
                        focusNode: _controller.usernameNode,
                        keyboardType: TextInputType.emailAddress,
                        onTap: () => _controller.usernameNode.requestFocus(),
                        onTapOutside: (_) => _controller.usernameNode.unfocus(),
                        onFieldSubmitted: (_) => _controller.nextFocus(),
                        decoration: InputDecoration(
                            errorText: _controller.usernameError,
                            labelText: "Nhập địa chỉ email"),
                      ),
        
                      // Example: Reset Password button
                      ...expand
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
