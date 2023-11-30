part of 'register_page.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: AppIcon(AppIcons.username),
                labelText: "Nhập địa chỉ email"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: AppIcon(AppIcons.info),
                labelText: "Nhập tên người dùng"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: AppIcon(AppIcons.password),
                labelText: "Nhập mật khẩu"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: AppIcon(AppIcons.password),
                labelText: "Nhập lại mật khẩu"),
          ),
          const SizedBox(height: 10),
          FilledButton(
              onPressed: _confirm,
              child: Center(
                child: Text("Đăng ký"),
              ))
        ],
      ),
    );
  }

  void _confirm() {}
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
            recognizer: TapGestureRecognizer()..onTap = _privacy,
            text: "Điều khoản sử dụng",
            mouseCursor: MaterialStateMouseCursor.clickable,
            style: AppTypology.textButtonLabel.merge(AppTypology.labelSmall))
      ]),
      textAlign: TextAlign.center,
      style: AppTypology.labelSmall,
    );
  }

  void _privacy() {}
}