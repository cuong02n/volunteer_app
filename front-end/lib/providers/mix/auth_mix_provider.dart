import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/providers/local/auth_local_provider.dart';
import 'package:thien_nguyen_app/providers/server/auth_provider.dart';

abstract class AuthMixProvider {
  static Future<bool> tryLogin() async{
    AuthRequest? request = await AuthLocalProvider.readLastUser();
    print(request);
    if (request == null) return false;
    try {
      AuthResponse response = await AuthServerProvider.authenticate(request);
      await AuthLocalProvider.saveToken(response);
      await AuthLocalProvider.saveUser(request);
      return true;
    }
    catch (e) {
     return false;
    }
  }
}