part of 'newpage_page.dart';

class NewPageForm extends StatefulWidget {
  const NewPageForm({super.key});

  @override
  State<NewPageForm> createState() => _NewPageFormState();
}

class _NewPageFormState extends State<NewPageForm> {
  late final CreateFanpageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateFanpageController(context);
    _controller.init();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller.nameController,
            focusNode: _controller.nameNode,
            keyboardType: TextInputType.name,
            onTap: () => _controller.nameNode.requestFocus(),
            onTapOutside: (_) => _controller.nameNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            decoration: InputDecoration(errorText: _controller.nameError,
                labelText: "Tên fanpage"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller.organizationController,
            focusNode: _controller.organizationNode,
            keyboardType: TextInputType.name,
            onTap: () => _controller.organizationNode.requestFocus(),
            onTapOutside: (_) => _controller.organizationNode.unfocus(),
            onFieldSubmitted: (_) => _controller.nextFocus(),
            decoration: InputDecoration(errorText: _controller.organizationError,
                labelText: "Tên tổ chức"),
          ),
          const SizedBox(height: 10),
          TextFormField(controller: _controller.descriptionController,
              focusNode: _controller.descriptionNode,
              keyboardType: TextInputType.multiline,
              onTap: () => _controller.descriptionNode.requestFocus(),
              onTapOutside: (_) => _controller.descriptionNode.unfocus(),
              onFieldSubmitted: (_) => _controller.nextFocus(),
              decoration: InputDecoration(errorText: _controller.descriptionError,
                labelText: "Giới thiệu về tổ chức"),
          ),
          const SizedBox(height: 10),
          ImagePickerField(
            controller: _controller.avatarController,
            title: "Thêm ảnh đại diện",
          ),
          const SizedBox(height: 10),
          ImagePickerField(
            controller: _controller.coverController,
            title: "Thêm ảnh bìa",
          ),
          const SizedBox(height: 10),
          FilledButton(
              onPressed: _controller.confirm,
              child: Center(
                child: Text("Tạo Fanpage"),
              ))
        ],
      ),
    );
  }
}