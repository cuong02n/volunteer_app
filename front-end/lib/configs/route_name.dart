///Tên đường dẫn các trang trong app
abstract class RoutePath {
  //Main branch
  static String home = "/";
  static String notification = "/notification";

  static String page = "/my-page";
  static String newPage = "new";

  static String specificPage = "/page/:pageID";

  static String user = "/user";
  static String edit = "edit";

  static String settings = "/settings";
  static String account = "/account";
  static String helpAndSupport = "/help-and-support";
  static String terms = "/terms";
  static String privacyPolicy = "/policy";
  static String anotherUser = "/user/:id";

  static String login = "/login";
  static String register = "new";
  static String otp = "otp";

  static String status = "/status";

  static String forgetPassword = "reset";
  static String resetPassword = "new";
}

///Tên các trang trong app
abstract class RouteName {
  //Main branch
  static String home = "home";
  static String notification = "notification";
  static String page = "page";
  static String user = "user";
  static String settings = "settings";
  static String account = "account";
  static String helpAndSupport = "helpAndSupport";
  static String terms = "terms";
  static String privacyPolicy = "policy";
  static String anotherUser = "anotherUser";
  static String forgetPassword = "forgetPassword";
  static String resetPassword = "resetPassword";

  static String login = "login";
  static String register = "register";

  static String status = "status";
  static String specificPage = "spage";
  static String newPage = "npage";
  //Sub branch
  static String edit = "edit";

  static String otp = "otp";
  static String forgetOtp = "forgetOtp";
}