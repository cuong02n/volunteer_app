
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/configs/regex/form_regex.dart';
import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/request/otp_request.dart';
import 'package:thien_nguyen_app/models/request/register_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/pages/loading/loading_page.dart';
import 'package:thien_nguyen_app/providers/local/auth_local_provider.dart';
import 'package:thien_nguyen_app/providers/server/auth_provider.dart';
import 'package:thien_nguyen_app/utilities/controllers/base_function.dart';

class OtpController with ChangeNotifier implements BaseFunction {
  bool isShowOtp = false;

  OtpController(this.context);

  final BuildContext context;

  late final TextEditingController otpController;
  late final String email;

  final FocusNode otpNode = FocusNode();

  String get otp => otpController.text;

  String? otpError;

  void init() {
    otpController = TextEditingController(text: "");
    email = GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['email'] ?? "";
    otpNode.addListener(() {
      otpError = null;
    });
  }

  void confirmOtp() async {
    try {
      Navigator.of(context).push(LoadingOverlay());
      OtpRequest request = OtpRequest(email: email, otp: otp);
      await AuthServerProvider.verifyRegister(request);
      //After finish
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
    confirmOtp();
  }


  @override
  void returnError(dynamic e) {
    if (e is DioException) {
      print(e.response);
    }
    else {
      otpError = e.toString();
    }
    // TODO: implement returnError
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }

  @override
  void validateForm() {

  }

  void setOtpShow() {
    isShowOtp = !isShowOtp;
    notifyListeners();
  }
}