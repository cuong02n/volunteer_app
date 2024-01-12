import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:thien_nguyen_app/models/entity/user.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/pages/loading/loading_page.dart';
import 'package:thien_nguyen_app/utilities/bloc/edit_controller_bloc.dart';
import 'package:thien_nguyen_app/utilities/controllers/files/image_picker_controller.dart';
import 'package:thien_nguyen_app/utilities/functions/base_function.dart';
import 'package:thien_nguyen_app/utilities/providers/user_avatar_provider.dart';

class EditUserController with ChangeNotifier implements BaseFunction {
  EditUserController(this.context);

  final BuildContext context;

  bool edited = false;

  final ImagePickerController avatarPickerController = ImagePickerController();
  final CurrentUserAvatarProvider provider = CurrentUserAvatarProvider();
  late final TextEditingController nameController;
  late final TextEditingController dobController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;


  final List<FocusNode> _nodes = List.generate(6, (index) => FocusNode());

  FocusNode get nameNode => _nodes[0];
  FocusNode get dobNode => _nodes[1];
  FocusNode get maleNode => _nodes[2];
  FocusNode get femaleNode => _nodes[3];
  FocusNode get phoneNode => _nodes[4];
  FocusNode get emailNode => _nodes[5];

  String get name => nameController.text;
  Gender gender = Gender.UNSPECIFIED;
  DateTime? get dob => DateTime.tryParse(dobController.text);
  String get phone => phoneController.text;
  String get retype => emailController.text;

  String? nameError;
  String? dobError;
  String? phoneError;
  String? emailError;

  bool isShowPassword = false;
  bool isShowRetypePassword = false;
  bool get isValid => [nameError, dobError, phoneError, emailError].every((element) => element == null);

  void init() {
    context.read<EditUserBloc>().emit(this);
    nameController = TextEditingController(text: CurrentInfo.user?.name ?? "");
    if (CurrentInfo.user?.gender != null) gender = CurrentInfo.user!.gender ?? Gender.UNSPECIFIED;
    dobController = TextEditingController(
        text: CurrentInfo.user?.dob == null ? "" : DateFormat.yMMMd().format(CurrentInfo.user!.dob!));
    phoneController = TextEditingController(text: CurrentInfo.user?.phoneNumber ?? "");
    emailController = TextEditingController(text: CurrentInfo.user?.email ?? "");
  }

  void confirm() async {
    validateForm();
    if (!isValid) return;
    Map<String, dynamic> json = {
      'name': name, 'phone': phone, 'dob': dob, 'gender': gender.toString().split('.').last
    };
    Map<String, dynamic> userInfo = CurrentInfo.user!.toJson();
    userInfo.addEntries(json.entries);
    User user = User.fromJson(userInfo);
    try {
      Navigator.of(context).push(LoadingOverlay());
      await UserServerRepository.editUser(user);
      print(CurrentInfo.user?.toJson());
      edited = true;
      if (context.mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chỉnh sửa thông tin thành công")));
      }
    } catch (e) {
      if (context.mounted) {
        context.pop();
        returnError(e);
      }
    }

  }

  void nextFocus() {
    int focusIndex = _nodes.indexWhere((node) => node.hasFocus);
    _nodes[focusIndex].unfocus();
    if (focusIndex + 1 < _nodes.length) {
      _nodes[focusIndex + 1].requestFocus();
    }
  }

  void validateUsername() {
    if (name.isNotEmpty) {
      nameError = null;
    }
    else {
      nameError = "Tên người dùng không được để trống";
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
    validateUsername();
  }

  void setGender(Gender? gender) {
    if (gender == null) return;
    if (gender == this.gender) {
      this.gender = Gender.UNSPECIFIED;
    } else {
      this.gender = gender;
    }
    notifyListeners();
  }

  void changeAvatar() async {
    try {
      XFile? newAvatar = await avatarPickerController.pickImage();
      if (newAvatar == null) return;
      await UserServerRepository.uploadAvatar(newAvatar);
      edited = true;
      notifyListeners();
    }
    catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}