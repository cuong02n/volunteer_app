part of 'login_page.dart';

class LoginPageBackground extends StatelessWidget {
  const LoginPageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.background,
        width: 100.w, height: 35.h, fit: BoxFit.fill);
  }
}

class LoginPageLogo extends StatelessWidget {
  const LoginPageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
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
    );
  }
}

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: AppIcon(AppIcons.username),
                  labelText: "Nhập địa chỉ email"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: AppIcon(AppIcons.password),
                  labelText: "Nhập mật khẩu"),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _forgotPassword,
                child: const Text("Quên mật khẩu"),
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(
                onPressed: _signIn, child: Center(child: Text("Đăng nhập"))),
            const SizedBox(height: 10),
            Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(text: "Chưa có tài khoản? "),
                TextSpan(
                    text: "Tạo tài khoản",
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    recognizer: TapGestureRecognizer()..onTap = _register,
                    style: AppTypology.textButtonLabel)
              ])),
            ),
          ],
        ),
      ),
    );
  }

  void _forgotPassword() {}

  void _signIn() {}

  void _register() {}
}

class LoginPagePrivacy extends StatelessWidget {
  const LoginPagePrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: "Bằng việc tiếp tục, bạn đã đồng ý với\n",
        ),
        TextSpan(
            recognizer: TapGestureRecognizer()..onTap = _privacy,
            text: "Điều khoản sử dụng",
            mouseCursor: MaterialStateMouseCursor.clickable,
            style: AppTypology.textButtonLabel)
      ]),
      textAlign: TextAlign.center,
    );
  }

  void _privacy() {}
}
