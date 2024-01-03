import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseApi {
  static String? baseUrl = (kIsWeb)? dotenv.env['BASE_WEB_URL']: dotenv.env['BASE_EMULATOR_URL'];
}

abstract class AuthApi {
  static String get authenticate => "${BaseApi.baseUrl}/api/v1/auth/authenticate";
  static String get register => "${BaseApi.baseUrl}/api/v1/auth/register";
  static String get verifyRegister => "${BaseApi.baseUrl}/api/v1/auth/verify_register";
  static String get resetPassword => "${BaseApi.baseUrl}/api/v1/auth/reset_password";
}