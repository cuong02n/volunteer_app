import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/pages/login/login_page.dart';

import '../../configs/app_icons.dart';
import '../../configs/app_images.dart';
import '../../configs/app_logo.dart';
import '../../theme/theme.dart';
import '../../widgets/app_icon.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
          const SizedBox(
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
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(
                      prefixIcon: AppIcon(AppIcons.password),
                      labelText: "Nhập mật khẩu mới"),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                      prefixIcon: AppIcon(AppIcons.password),
                      labelText: "Xác nhận mật khẩu mới"),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (newPasswordController.text ==
                      confirmPasswordController.text) {
                    // Passwords match, transfer to loginPage
                    _showSuccessDialog(context);
                  } else {
                    // Passwords do not match, reset formfield and notify 'password not match'
                    _showErrorDialog(context);
                    newPasswordController.clear();
                    confirmPasswordController.clear();
                    setState(() {});
                  }
                },
                child: const Text('XÁC NHẬN'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('Set up new password success'),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to the login page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: const Text('Passwords do not match'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
