part of 'account_page.dart';

class AccountPageBody extends StatefulWidget {
  const AccountPageBody({super.key});

  @override
  State<AccountPageBody> createState() => _AccountPageBodyState();
}

class _AccountPageBodyState extends State<AccountPageBody> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
          children: [
            UserAvatar(provider: CurrentUserAvatarProvider(), radius: 100),
            NavigationButton(title: "Email", extra: Text(CurrentInfo.user?.email ?? "Thêm địa chỉ email")),
            NavigationButton(title: "Tên người dùng", extra: Text(CurrentInfo.user?.name ?? "User name")),
            NavigationButton(title: "Mật khẩu", extra: Text("Đổi mật khẩu")),
            SizedBox(height: 10,),
            TextButton(onPressed: _deleteAccount, child: Text("Xóa tài khoản")),
            SizedBox(height: 10,),
            TextButton(onPressed: _logout, child: Text("Đăng xuất"))
          ],
        ),
    );
  }

  void _deleteAccount() {
  }

  void _logout() async {
    await AuthLocalRepository.logout();
    if (context.mounted) context.goNamed(RouteName.login);
  }
}