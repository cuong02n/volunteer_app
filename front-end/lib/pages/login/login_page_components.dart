part of 'login_page.dart';

class LoginPageBackground extends StatelessWidget {
  const LoginPageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.background, width: 100.w, fit: BoxFit.fitWidth);
  }
}

class LoginPageLogo extends StatelessWidget {
  const LoginPageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppLogo(),
        Text("ThienNguyen")
      ],
    );
  }
}

class LoginPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              prefix: Image.asset(AppIcons.username),
              hintText: "Nhập địa chỉ email"
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                prefix: Image.asset(AppIcons.username),
                hintText: "Nhập mật khẩu"
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _forgotPassword,
              child: const Text("Quên mật khẩu"),
            ),
          ),
          ElevatedButton(onPressed: _signIn, child: Text("Đăng nhập")),
          Center(
            child: Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: "Chưa có tài khoản"
                ),
                TextSpan(
                  text: "Tạo tài khoản",
                  onExit: _register
                )
              ]
            )),
          ),
        ],
      ),
    );
  }

  void _forgotPassword() {
  }

  void _signIn() {
  }

  void _register(PointerExitEvent event) {
  }
}

class LoginPagePrivacy extends StatelessWidget {
  const LoginPagePrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children:
          [TextSpan(
            text: "Bằng việc tiếp tục, bạn đã đồng ý với\n",
          ),
          TextSpan(
            onExit: _privacy,
            text: "Điều khoản sử dụng"
          )]
      ),
      textAlign: TextAlign.center,
    );
  }

  void _privacy(PointerExitEvent event) {
  }
}