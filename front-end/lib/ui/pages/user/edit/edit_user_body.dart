part of 'edit_user.dart';

class EditUserBody extends StatefulWidget {
  const EditUserBody({super.key});

  @override
  State<EditUserBody> createState() => _EditUserBodyState();
}

class _EditUserBodyState extends State<EditUserBody> {
  late final EditUserController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EditUserController(context);
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
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: [
              UserAvatar.collapsed(provider: _controller.provider),
              TextButton(onPressed: _controller.changeAvatar, child: Text("Chỉnh sửa")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tên tài khoản"),
                  TextFormField(
                    controller: _controller.nameController,
                    focusNode: _controller.nameNode,
                    keyboardType: TextInputType.name,
                    onTap: () => _controller.nameNode.requestFocus(),
                    onTapOutside: (_) => _controller.nameNode.unfocus(),
                    onFieldSubmitted: (_) => _controller.nextFocus(),
                    decoration: InputDecoration(errorText: _controller.nameError),
                  ),
                  SizedBox(height: 10),
                  Text("Giới tính"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: RadioMenuButton(
                              focusNode: _controller.maleNode,
                              value: Gender.MALE,
                              groupValue: _controller.gender,
                              onChanged: _controller.setGender,
                              child: Text("Nam"))),
                      Expanded(
                          child: RadioMenuButton(
                        focusNode: _controller.femaleNode,
                        value: Gender.FEMALE,
                        groupValue: _controller.gender,
                        onChanged: _controller.setGender,
                        child: Text("Nữ"),
                      ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Ngày sinh"),
                  TextFormField(
                    controller: _controller.dobController,
                    focusNode: _controller.dobNode,
                    keyboardType: TextInputType.datetime,
                    onTap: () => _controller.dobNode.requestFocus(),
                    onTapOutside: (_) => _controller.dobNode.unfocus(),
                    onFieldSubmitted: (_) => _controller.nextFocus(),
                    decoration: InputDecoration(errorText: _controller.dobError),
                  ),
                  SizedBox(height: 10),
                  Text("Số điện thoại"),
                  TextFormField(
                    controller: _controller.phoneController,
                    focusNode: _controller.phoneNode,
                    keyboardType: TextInputType.phone,
                    onTap: () => _controller.phoneNode.requestFocus(),
                    onTapOutside: (_) => _controller.phoneNode.unfocus(),
                    onFieldSubmitted: (_) => _controller.nextFocus(),
                    decoration:
                        InputDecoration(errorText: _controller.phoneError),
                  ),
                  SizedBox(height: 10),
                  Text("Email"),
                  TextFormField(
                    controller: _controller.emailController,
                    enabled: false,
                    focusNode: _controller.emailNode,
                    onTap: () => _controller.emailNode.requestFocus(),
                    onTapOutside: (_) => _controller.emailNode.unfocus(),
                    onFieldSubmitted: (_) => _controller.nextFocus(),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              )
            ],
          ),
        ),
    );
  }

  void _editAvatar() {}
}
