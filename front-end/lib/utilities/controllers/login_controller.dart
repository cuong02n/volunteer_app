import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/pages/loading/loading_page.dart';
import 'package:thien_nguyen_app/providers/local/auth_local_provider.dart';
import 'package:thien_nguyen_app/providers/server/auth_provider.dart';
import 'package:thien_nguyen_app/utilities/functions/base_function.dart';

class LoginController with ChangeNotifier implements BaseFunction {
  LoginController(this.context);

  final BuildContext context;

  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  final FocusNode usernameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  String get username => usernameController.text;
  String get password => passwordController.text;

  String? usernameError;
  String? passwordError;

  bool isShowPassword = false;

  void init() {
    usernameController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
  }

  void login() async {
    try {
      Navigator.of(context).push(LoadingOverlay());
      AuthRequest request = AuthRequest(email: username, password: password);
      AuthResponse response = await AuthServerProvider.authenticate(request);
      //After finish
      await AuthLocalProvider.saveToken(response);
      await AuthLocalProvider.saveUser(request);
      if (context.mounted) context.go('/');
    }
    catch (e) {
      if (context.mounted) {
        context.pop();
        returnError(e);
      }
    }
  }

  void nextFocus() {
    if (usernameNode.hasFocus) {
      usernameNode.unfocus();
      passwordNode.requestFocus();
    }
    else {
      passwordNode.unfocus();
      login();
    }
  }
  void validateUsername() {

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

  }

  void setPasswordShow() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
}