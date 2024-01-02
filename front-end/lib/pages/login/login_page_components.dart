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

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginController(context);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
        child: AutofillGroup(
          child: Column(
            children: [
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
                    prefixIcon: const AppIcon(AppIcons.username),
                    labelText: "Nhập địa chỉ email"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                autofillHints: const [AutofillHints.password],
                controller: _controller.passwordController,
                focusNode: _controller.passwordNode,
                onTap: () => _controller.passwordNode.requestFocus(),
                onTapOutside: (_) => _controller.passwordNode.unfocus(),
                onFieldSubmitted: (_) => _controller.nextFocus(),
                obscureText: !_controller.isShowPassword,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon((_controller.isShowPassword)? Icons.visibility_off: Icons.visibility),
                      onPressed: _controller.setPasswordShow,
                    ),
                    errorText: _controller.passwordError,
                    prefixIcon: const AppIcon(AppIcons.password),
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
                  onPressed: _controller.login, child: const Center(child: Text("Đăng nhập"))),
              const SizedBox(height: 10),
              Center(
                child: Text.rich(TextSpan(children: [
                  const TextSpan(text: "Chưa có tài khoản? "),
                  TextSpan(
                      text: "Tạo tài khoản",
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      recognizer: TapGestureRecognizer()..onTap = _register(context),
                      style: AppTypology.textButtonLabel)
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _forgotPassword() {}

  VoidCallback _register(BuildContext context) => () {
    context.pushNamed(RouteName.register);
  };
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
