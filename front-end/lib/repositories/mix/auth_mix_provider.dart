import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/repositories/local/auth_local_provider.dart';
import 'package:thien_nguyen_app/repositories/server/auth_provider.dart';

abstract class AuthMixRepository {
  static Future<bool> tryLogin() async{
    AuthRequest? request = await AuthLocalRepository.readLastUser();
    print(request);
    if (request == null) return false;
    try {
      AuthResponse response = await AuthServerRepository.authenticate(request);
      await AuthLocalRepository.saveToken(response);
      await AuthLocalRepository.saveUser(request);
      return true;
    }
    catch (e) {
     return false;
    }
  }
}