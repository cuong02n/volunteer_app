import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/request/reset_password_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/pages/loading/loading_page.dart';
import 'package:thien_nguyen_app/providers/local/auth_local_provider.dart';
import 'package:thien_nguyen_app/providers/server/auth_provider.dart';
import 'package:thien_nguyen_app/utilities/controllers/base_function.dart';

class ResetPasswordController with ChangeNotifier implements BaseFunction {
  ResetPasswordController(this.context);

  final BuildContext context;

  late final TextEditingController usernameController;

  final FocusNode usernameNode = FocusNode();

  String get username => usernameController.text;

  String? usernameError;

  void init() {
    usernameController = TextEditingController(text: "");
  }

  void resetPassword() async {
    try {
      Navigator.of(context).push(LoadingOverlay());
      ResetPasswordRequest request = ResetPasswordRequest(email: username);
      ResetP response = await AuthServerProvider.authenticate(request);
      //After finish

      if (context.mounted) context.pushNamed(RouteName.forgetOtp, queryParameters: {"email": username});
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