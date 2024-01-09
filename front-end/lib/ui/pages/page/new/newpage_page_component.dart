part of 'newpage_page.dart';

class NewPageForm extends StatefulWidget {
  final Fanpage? fanpage;
  const NewPageForm({super.key, this.fanpage});

  @override
  State<NewPageForm> createState() => _NewPageFormState();
}

class _NewPageFormState extends State<NewPageForm> {
  late final EditFanpageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EditFanpageController(context, fanpage: widget.fanpage);
    _controller.addListener(() {
      setState(() {});
    });
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
                labelText: "Tên tổ chức"),
          ),
          const SizedBox(height: 10),
          TextFormField(controller: _controller.descriptionController,
              focusNode: _controller.descriptionNode,
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
            initialUrl: widget.fanpage?.avatarImage,
          ),
          const SizedBox(height: 10),
          ImagePickerField(
            controller: _controller.coverController,
            title: "Thêm ảnh bìa",
            initialUrl: widget.fanpage?.coverImage,
          ),
          const SizedBox(height: 10),
          FilledButton(
              onPressed: _controller.confirm,
              child: Center(
                child: Text(widget.fanpage == null? "Tạo Fanpage": "Cập nhật"),
              ))
        ],
      ),
    );
  }
}