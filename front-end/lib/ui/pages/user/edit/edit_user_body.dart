part of 'edit_user.dart';

class EditUserBody extends StatefulWidget {
  const EditUserBody({super.key});

  @override
  State<EditUserBody> createState() => _EditUserBodyState();
}

class _EditUserBodyState extends State<EditUserBody> {
  bool? _isMale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
            ),
            TextButton(onPressed: _editAvatar, child: Text("Chỉnh sửa")),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tên tài khoản"),
                TextFormField(),
                SizedBox(height: 10),
                Text("Giới tính"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: RadioMenuButton(value: true, groupValue: _isMale, onChanged: _changeGender, child: Text("Nam"))),
                    Expanded(child: RadioMenuButton(value: false, groupValue: _isMale, onChanged: _changeGender, child: Text("Nữ"),))
                  ],
                ),
                SizedBox(height: 10),
                Text("Ngày sinh"),
                TextFormField(),
                SizedBox(height: 10),
                Text("Số điện thoại"),
                TextFormField(),
                SizedBox(height: 10),
                Text("Email"),
                TextFormField(),
                SizedBox(height: 40,)
              ],
            )
          ],
        ),
      ),
    );
  }

  void _toDev() {}

  void _editAvatar() {
  }

  void _changeGender(bool? value) {
    setState(() {
      _isMale = value;
    });
  }
}
