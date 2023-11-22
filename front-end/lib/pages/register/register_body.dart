part of 'register_page.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Đăng ký", style: AppTypology.titleMedium.copyWith(color: context.appTheme.primaryColor)),
                Container(
                  height: 10,
                  width: 60.w,
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide())
                  ),
                ),
                RegisterForm(),
                const SizedBox(height: 10),
                RegisterPolicy()
              ],
            ),
        ),
      ),
    );
  }
}