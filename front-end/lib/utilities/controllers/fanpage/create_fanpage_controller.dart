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

class CreateFanpageController with ChangeNotifier implements BaseFunction {
  CreateFanpageController(this.context);

  final BuildContext context;

  bool edited = false;

  late final TextEditingController nameController;
  late final TextEditingController organizationController;
  late final TextEditingController descriptionController;
  final ImagePickerController avatarController = ImagePickerController();
  final ImagePickerController coverController = ImagePickerController();

  final List<FocusNode> _nodes = List.generate(3, (index) => FocusNode());

  FocusNode get nameNode => _nodes[0];
  FocusNode get organizationNode => _nodes[1];
  FocusNode get descriptionNode => _nodes[2];

  String get name => nameController.text;
  String get organization => organizationController.text;
  String get description => descriptionController.text;
  XFile? avatar;
  XFile? cover;

  String? nameError;
  String? organizationError;
  String? descriptionError;

  bool get isValid => [nameError, organizationError, descriptionError].every((element) => element == null);

  void init() {
    nameController = TextEditingController(text: "");
    organizationController = TextEditingController(
        text: "");
    descriptionController = TextEditingController(text: "");
  }

  void confirm() async {
    validateForm();
    if (!isValid) return;
    try {
      Navigator.of(context).push(LoadingOverlay());
      final Fanpage request = Fanpage(fanpageName: name);
      Fanpage response = await FanpageServerRepository.createFanpage(request);
      if (context.mounted) {
        context.pop();
        context.pop(response);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thêm fanpage thành công")));
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
    if (name.isNotEmpty) {
      nameError = null;
    }
    else {
      nameError = "Tên người dùng không được để trống";
    }
    notifyListeners();
  }

  void validateOrganization() {
    if (organization.isNotEmpty) {
      organizationError = null;
    }
    else {
      organizationError = "Tên người dùng không được để trống";
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
    validateOrganization();
  }

  void changeAvatar() async {
      XFile? newAvatar = await avatarController.pickImage();
      if (newAvatar == null) return;
      avatar = newAvatar;
      notifyListeners();
  }

  void changeCover() async {
    XFile? newCover = await avatarController.pickImage();
    if (newCover == null) return;
    cover = newCover;
    notifyListeners();
  }
}