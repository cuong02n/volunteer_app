part of 'newpage_page.dart';

class NewPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: "Tên fanpage"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Tên tổ chức"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Giới thiệu về tổ chức"),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          FilledButton(
              onPressed: _confirm,
              child: Center(
                child: Text("Tạo Fanpage"),
              ))
        ],
      ),
    );
  }

  void _confirm() {}
}