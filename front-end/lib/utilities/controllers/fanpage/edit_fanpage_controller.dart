import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:thien_nguyen_app/repositories/server/fanpage_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/pages/loading/loading_page.dart';

import 'package:thien_nguyen_app/utilities/controllers/files/image_picker_controller.dart';
import 'package:thien_nguyen_app/utilities/functions/base_function.dart';

class EditFanpageController with ChangeNotifier implements BaseFunction {
  Fanpage? fanpage;
  EditFanpageController(this.context, {this.fanpage});

  final BuildContext context;

  bool edited = false;

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  final ImagePickerController avatarController = ImagePickerController();
  final ImagePickerController coverController = ImagePickerController();

  final List<FocusNode> _nodes = List.generate(2, (index) => FocusNode());

  FocusNode get nameNode => _nodes[0];
  FocusNode get descriptionNode => _nodes[1];

  String get name => nameController.text;
  String get description => descriptionController.text;
  XFile? get avatar => avatarController.image;
  XFile? get cover => coverController.image;

  String? nameError;
  String? descriptionError;

  bool get isValid => [nameError, descriptionError].every((element) => element == null);

  void init() {
    nameController = TextEditingController(text: fanpage?.fanpageName ?? "");
    descriptionController = TextEditingController(text: fanpage?.description ?? "");
  }

  void confirm() async {
    validateForm();
    if (!isValid) return;
    try {
      Navigator.of(context).push(LoadingOverlay());
      final Fanpage request = Fanpage(fanpageName: name, description: description);
      Fanpage response;
      if (fanpage == null) {
        response = await FanpageServerRepository.createFanpage(request, avatar: avatar, cover: cover);
      } else {
        response = await FanpageServerRepository.editFanpage(fanpage!.id!, request, avatar: avatar, cover: cover);
      }
      if (context.mounted) {
        context.pop();
        context.pop(response);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text((fanpage == null)? "Thêm fanpage thành công": "Chỉnh sửa thông tin thành công")));
      }
    } catch (e) {
      if (context.mounted) context.pop();
      returnError(e);
    }
  }

  void nextFocus() {
    int focusIndex = _nodes.indexWhere((node) => node.hasFocus);
    _nodes[focusIndex].unfocus();
    if (focusIndex + 1 < _nodes.length) {
      _nodes[focusIndex + 1].requestFocus();
    }
  }

  void validateFanpageName() {
    if (name.length > 4 && name.length < 100) {
      nameError = null;
    }
    else {
      nameError = "Tên tổ chức không được để trống";
    }
    notifyListeners();
  }

  @override
  void returnError(dynamic e) {
    if (e is DioException) {
      print(e.response);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }

  @override
  void validateForm() {
    validateFanpageName();
  }
}