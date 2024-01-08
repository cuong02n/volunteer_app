import 'dart:async';

import 'package:thien_nguyen_app/models/entity/user.dart';

abstract class CurrentInfo {
  static User? user;
  static Timer? refreshToken;
  static bool isRefresh = false;
}