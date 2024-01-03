import 'package:dio/dio.dart';
import 'package:thien_nguyen_app/configs/server_api.dart';
import 'package:thien_nguyen_app/models/request/auth_request.dart';
import 'package:thien_nguyen_app/models/request/otp_request.dart';
import 'package:thien_nguyen_app/models/request/register_request.dart';
import 'package:thien_nguyen_app/models/request/reset_password_request.dart';
import 'package:thien_nguyen_app/models/response/auth_response.dart';

import 'dio.dart';

abstract class UserServerProvider {
  ///Register new account
  static Future<void> getUser(int id) async {
    //Call response
    try {
      final response = await dio.get(UserApi.getUser(id));
      if (response.statusCode != 200) throw response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) throw "Tài khoản đã tồn tại";
      throw "Lỗi kết nối";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<void> verifyRegister(OtpRequest data) async {
    try {
      final response = await dio.post(AuthApi.verifyRegister, data: data);
      if (response.statusCode != 200) throw response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 406) throw "Otp hết hạn hoặc không chính xác";
      throw "Lỗi kết nối";
    }
    catch (e) {
      rethrow;
    }
  }

  ///Login
  static Future<AuthResponse> authenticate(AuthRequest data) async {
    try{
      final response = await dio.post(AuthApi.authenticate, data: data);
      if (response.statusCode == 200) {

        return AuthResponse.fromJson(response.data);
      }
      else {
        throw response;
      }
    }
    on DioException catch (e) {
      if (e.response?.statusCode == 403) throw "Sai mật khẩu hoặc tài khoản không tồn tại";
      throw "Lỗi kết nối";
    }
    catch (e) {
      rethrow;
    }
  }

  ///Reset password
  static Future<bool> checkExist(ResetPasswordRequest data) async {
    //Call response
    try {
      final response = await dio.post(AuthApi.resetPassword, queryParameters: {'email': data.email});
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) throw "Không tồn tại email";
      throw "Lỗi kết nối";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<void> resetPassword(ResetPasswordRequest data) async {
    try {
      final response = await dio.put(AuthApi.resetPassword, data: data);
      if (response.statusCode != 200) {
        throw response;
      }
    }
    on DioException catch (e) {
      print(e);
      if (e.response?.statusCode == 406) throw "Otp hết hạn hoặc không chính xác";
      else throw "Lỗi kết nối";
    }
    catch (e) {
      rethrow;
    }
  }
}