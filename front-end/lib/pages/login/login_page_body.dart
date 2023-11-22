part of 'login_page.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h - 10,
      child: const Column(
        children: [
          LoginPageBackground(),
          LoginPageLogo(),
          LoginPageForm(),
          Flexible(child: Align(
            alignment: Alignment.bottomCenter,
            child: LoginPagePrivacy(),
          ))
        ],
      ),
    );
  }

}