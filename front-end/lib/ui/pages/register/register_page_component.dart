part of 'register_page.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final RegisterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RegisterController(context);
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
    return Form(
      child: AutofillGroup(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofillHints: const [AutofillHints.email],
              controller: _controller.emailController,
              focusNode: _controller.emailNode,
              onTap: () => _controller.emailNode.requestFocus(),
              onTapOutside: (_) => _controller.emailNode.unfocus(),
              onFieldSubmitted: (_) {
                _controller.validateEmail();
                if (_controller.emailError == null) _controller.nextFocus();
              },
              decoration: InputDecoration(
                  errorText: _controller.emailError,
                  prefixIcon: AppIcon(AppIcons.username),
                  labelText: "Nhập địa chỉ email"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              autofillHints: const [AutofillHints.newUsername],
              controller: _controller.usernameController,
              focusNode: _controller.usernameNode,
              onTap: () => _controller.usernameNode.requestFocus(),
              onTapOutside: (_) => _controller.usernameNode.unfocus(),
              onFieldSubmitted: (_) => _controller.nextFocus(),
              decoration: InputDecoration(
                errorText: _controller.usernameError,
                  prefixIcon: AppIcon(AppIcons.info),
                  labelText: "Nhập tên người dùng"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              autofillHints: const [AutofillHints.newPassword],
              controller: _controller.passwordController,
              focusNode: _controller.passwordNode,
              onTap: () => _controller.passwordNode.requestFocus(),
              onTapOutside: (_) => _controller.passwordNode.unfocus(),
              onFieldSubmitted: (_) {
                _controller.validatePassword();
                if (_controller.passwordError == null) _controller.nextFocus();
              },
              obscureText: !_controller.isShowPassword,
              decoration: InputDecoration(
                errorText: _controller.passwordError,
                  suffixIcon: IconButton(
                      icon: Icon((_controller.isShowPassword)? Icons.visibility_off: Icons.visibility),
                      onPressed: _controller.setPasswordShow),
                  prefixIcon: AppIcon(AppIcons.password),
                  labelText: "Nhập mật khẩu"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _controller.retypePasswordController,
              focusNode: _controller.retypePasswordNode,
              onTap: () => _controller.retypePasswordNode.requestFocus(),
              onTapOutside: (_) => _controller.retypePasswordNode.unfocus(),
              onFieldSubmitted: (_) {
                _controller.validateRetypePassword();
                if (_controller.retypePasswordError == null) _controller.nextFocus();
              },
              obscureText: !_controller.isShowRetypePassword,
              decoration: InputDecoration(
                errorText: _controller.retypePasswordError,
                  suffixIcon: IconButton(
                      icon: Icon((_controller.isShowRetypePassword)? Icons.visibility_off: Icons.visibility),
                      onPressed: _controller.setRetypePasswordShow),
                  prefixIcon: AppIcon(AppIcons.password),
                  labelText: "Nhập lại mật khẩu"),
            ),
            const SizedBox(height: 10),
            FilledButton(
                onPressed: _controller.register,
                child: Center(
                  child: Text("Đăng ký"),
                ))
          ],
        ),
      ),
    );
  }
}

class RegisterPolicy extends StatelessWidget {
  const RegisterPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: "Bằng việc tiếp tục, bạn đã đồng ý với\n",
        ),
        TextSpan(
            recognizer: TapGestureRecognizer()..onTap = _privacy(context),
            text: "Điều khoản sử dụng",
            mouseCursor: MaterialStateMouseCursor.clickable,
            style: AppTypology.textButtonLabel.merge(AppTypology.labelSmall))
      ]),
      textAlign: TextAlign.center,
      style: AppTypology.labelSmall,
    );
  }

  VoidCallback _privacy(BuildContext context) {
    return () {
      context.pushNamed(RouteName.privacyPolicy);
    };
  }
}