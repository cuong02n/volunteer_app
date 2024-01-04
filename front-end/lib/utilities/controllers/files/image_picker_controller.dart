
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _files = [];

  XFile? get image => _files.elementAtOrNull(0);

  List<XFile> get images => _files;

  Future<XFile?> pickImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _files = [image];
      notifyListeners();
    }
    return image;
  }

  Future<void> pickMultiImage() async {
    _files = await _picker.pickMultiImage();
    notifyListeners();
  }
}