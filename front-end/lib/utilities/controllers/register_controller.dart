import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/configs/regex/form_regex.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/request/register_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/pages/loading/loading_page.dart';
import 'package:thien_nguyen_app/repositories/local/auth_local_provider.dart';
import 'package:thien_nguyen_app/repositories/server/auth_provider.dart';
import 'package:thien_nguyen_app/utilities/functions/base_function.dart';

class RegisterController with ChangeNotifier implements BaseFunction {
  RegisterController(this.context);

  final BuildContext context;

  late final TextEditingController emailController;
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController retypePasswordController;

  final List<FocusNode> _nodes = List.generate(4, (index) => FocusNode());

  FocusNode get emailNode => _nodes[0];
  FocusNode get usernameNode => _nodes[1];
  FocusNode get passwordNode => _nodes[2];
  FocusNode get retypePasswordNode => _nodes[3];

  String get email => emailController.text;
  String get username => usernameController.text;
  String get password => passwordController.text;
  String get retype => retypePasswordController.text;

  String? emailError;
  String? usernameError;
  String? passwordError;
  String? retypePasswordError;

  bool isShowPassword = false;
  bool isShowRetypePassword = false;
  bool get isValid => [emailError, usernameError, passwordError, retypePasswordError].every((element) => element == null);

  void init() {
    emailController = TextEditingController(text: "");
    usernameController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
    retypePasswordController = TextEditingController(text: "");
  }

  void register() async {
    validateForm();
    if (!isValid) return;
    try {
      Navigator.of(context).push(LoadingOverlay());
      RegisterRequest request = RegisterRequest(name: username, email: email, password: password);
      await AuthServerRepository.register(request);
      //After finish
      if (context.mounted) {
        context.pop();
        context.pushNamed(RouteName.otp, queryParameters: {'email': email});
      }
    }
    catch (e) {
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

  void validateEmail() {
    RegExp regex = FormRegExp.email;
    if (regex.hasMatch(email)) {
      emailError = null;
    }
    else {
      emailError = "Tên email không hợp lệ";
    }
    notifyListeners();
  }

  void validateUsername() {
    if (username.isNotEmpty) {
      usernameError = null;
    }
    else {
      usernameError = "Tên người dùng không được để trống";
    }
    notifyListeners();
  }

  void validatePassword() {
    RegExp regex = FormRegExp.password;
    if (regex.hasMatch(password)) {
      passwordError = null;
    }
    else {
      passwordError = "Mật khẩu không hợp lệ";
    }
    notifyListeners();
  }

  void validateRetypePassword() {
    if (password == retype) {
      retypePasswordError = null;
    }
    else {
      retypePasswordError = "Mật khẩu nhập lại không khớp";
    }
    notifyListeners();
  }

  @override
  void returnError(dynamic e) {
    if (e is DioException) {
      print(e.response);
    }
    // TODO: implement returnError
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }

  @override
  void validateForm() {
    validateEmail();
    validatePassword();
    validateRetypePassword();
  }

  void setPasswordShow() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  void setRetypePasswordShow() {
    isShowRetypePassword = !isShowRetypePassword;
    notifyListeners();
  }
}