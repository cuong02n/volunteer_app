import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseApi {
  static String? baseUrl = (kIsWeb)? dotenv.env['BASE_WEB_URL']: dotenv.env['BASE_EMULATOR_URL'];
  static String? bankUrl = dotenv.env['BANK_URL'];
}

abstract class AuthApi {
  static String get authenticate => "${BaseApi.baseUrl}/api/v1/auth/authenticate";
  static String get register => "${BaseApi.baseUrl}/api/v1/auth/register";
  static String get verifyRegister => "${BaseApi.baseUrl}/api/v1/auth/verify_register";
  static String get resetPassword => "${BaseApi.baseUrl}/api/v1/auth/reset_password";
}

abstract class UserApi {
  static String getUser(int id) => "${BaseApi.baseUrl}/api/users/$id";
  static String putUser(int id) => "${BaseApi.baseUrl}/api/users/$id";
  static String postCoverImage(int id) => "${BaseApi.baseUrl}/api/users/$id/update_cover_image";
  static String postAvatarImage(int id) => "${BaseApi.baseUrl}/api/users/$id/update_avatar_image";
  static String get getAllUsers => "${BaseApi.baseUrl}/api/users";
}

abstract class FanpageApi {
  static String getFanpage(int id) => "${BaseApi.baseUrl}/api/fanpages/$id";
  static String putFanpage(int id) => "${BaseApi.baseUrl}/api/fanpages/$id";
  static String deleteFanpage(int id) => "${BaseApi.baseUrl}/api/fanpages/$id";
  static String get getAllFanpages => "${BaseApi.baseUrl}/api/fanpages";
  static String get createFanpage => "${BaseApi.baseUrl}/api/fanpages";
  static String verifyFanpage(int id) => "${BaseApi.baseUrl}/api/fanpages/admin/verify/$id";
}

abstract class EventApi {
  static String putEvent(int id) => "${BaseApi.baseUrl}/api/events/$id";
  static String updateEventImage(int id) => "${BaseApi.baseUrl}/api/events/$id/update_image";
  static String get postNewEvent => "${BaseApi.baseUrl}/api/events/new_event";
  static String verifyEvent(int id) => "${BaseApi.baseUrl}/api/events/admin/verify/$id";
  static String get getSpecificEvent => "${BaseApi.baseUrl}/api/events/get_event";
}

abstract class DonationApi {
  static String get getAllDonations => "${BaseApi.baseUrl}/api/donations";
  static String get createDonation => "${BaseApi.baseUrl}/api/donations";
  static String getDonation(int id) => "${BaseApi.baseUrl}/api/donations/$id";
  static String deleteDonation(int id) => "${BaseApi.baseUrl}/api/donations/$id";
}

abstract class BankApi {
  static String get getAllBank => "${BaseApi.baseUrl}/banks";
}
