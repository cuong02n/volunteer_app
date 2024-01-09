import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/image_preview.dart';
import 'package:thien_nguyen_app/utilities/controllers/files/image_picker_controller.dart';

class ImagePickerField extends StatefulWidget {
  final BoxDecoration? style;
  final String title;
  final ImagePickerController? controller;
  final String? initialUrl;

  const ImagePickerField(
      {super.key, this.style, this.title = "", this.controller, this.initialUrl});

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  late final ImagePickerController _controller;
  XFile? _image;

  BoxDecoration get _defaultDecoration => BoxDecoration(
    border: Border.all(color: context.appTheme.colorScheme.secondary),
    borderRadius: BorderRadius.circular(10),
  );

  Widget get imagePreview {
    if (_image == null) {
      if (widget.initialUrl != null) {
        return ImagePreview.fromWeb(widget.initialUrl!);
      }
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ImagePreview.fromPath(_image!.path),
      );
    }
  }

  @override
  void initState() {
    _controller = widget.controller ?? ImagePickerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: widget.style ?? _defaultDecoration,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: context.appTheme.textTheme.labelLarge,),
                OutlinedButton(onPressed: _chooseFile, child: Text("Chọn file"))
              ],
            ),
            imagePreview
          ],
        ));
  }

  void _chooseFile() async {
    XFile? file = await _controller.pickImage();
    if (file != null) {
      setState(() {
        _image = file;
      });
    }
  }
}

