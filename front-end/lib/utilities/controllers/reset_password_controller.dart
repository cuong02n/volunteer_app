import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/configs/regex/form_regex.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/request/reset_password_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/pages/loading/loading_page.dart';
import 'package:thien_nguyen_app/repositories/local/auth_local_provider.dart';
import 'package:thien_nguyen_app/repositories/server/auth_provider.dart';
import 'package:thien_nguyen_app/utilities/functions/base_function.dart';

class ResetPasswordController with ChangeNotifier implements BaseFunction {
  bool isShowPassword = false;
  bool isShowRetypePassword = false;
  bool isShowOtp = false;

  ResetPasswordController(this.context);

  final BuildContext context;
  bool isExpanded = false;

  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController retypePasswordController;
  late final TextEditingController otpController;

  final List<FocusNode> _nodes = List.generate(4, (index) => FocusNode());

  FocusNode get usernameNode => _nodes[0];
  FocusNode get passwordNode => _nodes[1];
  FocusNode get retypePasswordNode => _nodes[2];
  FocusNode get otpNode => _nodes[3];

  String get username => usernameController.text;
  String get password => passwordController.text;
  String get retypePassword => retypePasswordController.text;
  String get otp => otpController.text;

  String? usernameError;
  String? passwordError;
  String? retypePasswordError;
  String? otpError;

  bool get isValid => [usernameError, passwordError, retypePasswordError, otpError].every((element) => element == null);

  void init() {
    usernameController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
    retypePasswordController = TextEditingController(text: "");
    otpController = TextEditingController(text: "");
    usernameNode.addListener(() {
      usernameError = null;
      notifyListeners();
    });
    passwordNode.addListener(() {
      passwordError = null;
      notifyListeners();
    });
    retypePasswordNode.addListener(() {
      retypePasswordError = null;
      notifyListeners();
    });
    otpController.addListener(() {
      otpError = null;
      notifyListeners();
    });
  }

  void checkExists() async {
    validateEmail();
    if (!isValid) return;
    bool isExists = false;
    try {
      Navigator.of(context).push(LoadingOverlay());
      ResetPasswordRequest request = ResetPasswordRequest(email: username);
      isExists = await AuthServerRepository.checkExist(request);
    }
    on DioException catch (e) {
      isExists = false;
    }
    catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      isExists = false;
    }
    finally {
      if (context.mounted) context.pop();
      isExpanded = isExists;
      notifyListeners();
    }
  }

  void resetPassword() async {
    validateForm();
    if (!isValid) return;
    try {
      Navigator.of(context).push(LoadingOverlay());
      ResetPasswordRequest request = ResetPasswordRequest(email: username, newPassword: password, otp: otp);
      await AuthServerRepository.resetPassword(request);
      if (context.mounted) {
        context.pop();
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đổi mật khẩu thành công")));
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
    if (!isExpanded) {
      usernameNode.unfocus();
    }
    else {
      int index = _nodes.indexWhere((element) => element.hasFocus);
      _nodes[index].unfocus();
      if (index + 1 < _nodes.length) {
        _nodes[index + 1].requestFocus();
      }
    }
  }

  void validateEmail() {
    RegExp regex = FormRegExp.email;
    if (regex.hasMatch(username)) {
      usernameError = null;
    }
    else {
      usernameError = "Tên email không hợp lệ";
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
    if (password == retypePassword) {
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

  void setOtpShow() {
    isShowOtp = !isShowOtp;
    notifyListeners();
  }
}