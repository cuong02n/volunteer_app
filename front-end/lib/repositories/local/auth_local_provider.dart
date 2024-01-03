import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';
import 'package:thien_nguyen_app/repositories/local/storage.dart';
import 'package:thien_nguyen_app/repositories/server/dio.dart';

abstract class AuthLocalRepository {
  static Future<void> saveToken(AuthResponse response) async {
    await storage.write(key: 'accessToken', value: response.token!);
    await storage.write(key: 'userId', value: response.userId!.toString());
  }

  static Future<void> saveUser(AuthRequest request) async {
    await storage.write(key: 'username', value: request.email);
    await storage.write(key: 'password', value: request.password);
    DateTime validDate = DateTime.now().add(const Duration(days: 7));
    await storage.write(key: 'validDate', value: validDate.toIso8601String());
  }

  static Future<void> logout() async {
    await storage.delete(key: 'password');
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'userId');
    await storage.delete(key: 'validDate');
    headers.remove('Authorization');
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