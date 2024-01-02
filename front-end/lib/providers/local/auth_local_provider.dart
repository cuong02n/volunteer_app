import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/providers/local/storage.dart';

abstract class AuthLocalProvider {
  static void saveToken(AuthResponse response) async {
    await storage.write(key: 'accessToken', value: response.token!);
    await storage.write(key: 'userId', value: response.userId!.toString());
  }

  static void saveUser(AuthRequest request) async {
    await storage.write(key: 'username', value: request.email);
    await storage.write(key: 'password', value: request.password);
    DateTime validDate = DateTime.now().add(const Duration(days: 7));
    await storage.write(key: 'validDate', value: validDate.toIso8601String());
  }

  static Future<AuthRequest?> readLastUser() async {
    String? email = await storage.read(key: 'username');
    String? password = await storage.read(key: 'password');
    DateTime? validDate = DateTime.tryParse(await storage.read(key: 'validDate') ?? "");
    if (validDate == null) return null;
    if (DateTime.now().compareTo(validDate) < 0) {
      return AuthRequest(email: email, password: password);
    }
    else {
      return null;
    }
  }
}