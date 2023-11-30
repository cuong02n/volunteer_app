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
            CircleAvatar(
              radius: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text("User Name", style: AppTypology.titleMedium,),
            ),
            NavigationButton(title: "Email", extra: Text("Thêm địa chỉ email")),
            NavigationButton(title: "Tên người dùng", extra: Text("User name")),
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

  void _logout() {
  }
}