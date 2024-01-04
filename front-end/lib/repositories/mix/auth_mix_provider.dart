import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thien_nguyen_app/configs/route_name.dart';
import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/repositories/local/auth_local_provider.dart';
import 'package:thien_nguyen_app/repositories/server/auth_provider.dart';
import 'package:thien_nguyen_app/repositories/server/user_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/routes/app_branch.dart';

abstract class AuthMixRepository {
  static Future<bool> tryLogin() async{
    AuthRequest? request = await AuthLocalRepository.readLastUser();
    print(request);
    if (request == null) return false;
    try {
      AuthResponse response = await AuthServerRepository.authenticate(request);
      CurrentInfo.user = await UserServerRepository.getUser(response.userId!);
      await AuthLocalRepository.saveToken(response);
      await AuthLocalRepository.saveUser(request);
      await setRefreshToken();
      return true;
    }
    catch (e) {
     return false;
    }
  }
  
  static Future<void> setRefreshToken() async {
    CurrentInfo.refreshToken = Timer.periodic(const Duration(minutes: 20), (timer) async {
      int turn = 5;
      while (turn-- > 0) {
        bool result = await tryLogin();
        if (result) return;
      }
      await AuthLocalRepository.logout();
      showDialog(context: navigatorKey.currentContext!, builder: (context) => AlertDialog(
        title: const Text("Phiên làm việc đã hết hạn"),
        content: const Text("Trở về màn hình đăng nhập để tiếp tục"),
        actions: [
          TextButton(onPressed: () => context.goNamed(RouteName.login), child: const Text("OK"))
        ],
      ));
    });
  }  
}