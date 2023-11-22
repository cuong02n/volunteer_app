part of 'login_page.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Column(
        children: [
          LoginPageBackground(),
          LoginPageLogo(),
          Flexible(child: LoginPageForm()),
          Expanded(child: Align(
            alignment: Alignment.bottomCenter,
            child: LoginPagePrivacy(),
          ))
        ],
      ),
    );
  }

}