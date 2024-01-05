import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thien_nguyen_app/configs/server_api.dart';
import 'package:thien_nguyen_app/models/entity/user.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';

import 'dio.dart';

abstract class UserServerRepository {
  ///Get user information
  static Future<User> getUser(int id) async {
    //Call response
    try {
      final response = await dio.get(UserApi.getUser(id));
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
      else {
        throw response;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) throw "Tài khoản đã tồn tại";
      throw "Lỗi kết nối";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<List<User>> getAllUser() async {
    //Call response
    try {
      final response = await dio.get(UserApi.getAllUsers);
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => User.fromJson(e)).toList();
      }
      else {
        throw response;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) throw "Tài khoản đã tồn tại";
      throw "Lỗi kết nối";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<void> editUser(User data) async {
    try {
      final response = await dio.put(UserApi.putUser(CurrentInfo.user!.id!), data: data);
      if (response.statusCode != 200) throw response;
      else {
        CurrentInfo.user = data;
      }
    } on DioException catch (e) {
      throw "Chỉnh sửa thông tin thất bại";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<void> uploadAvatar(XFile image) async {
    try {
      List<int> bytes = await image.readAsBytes();
      MultipartFile file = MultipartFile.fromBytes(bytes,
          filename: image.name,
          contentType: MediaType("image", image.name.split('.').last));
      FormData formData = FormData.fromMap({'image': file});
      final response = await dio.post(UserApi.postAvatarImage(CurrentInfo.user!.id!), data: formData,);
      if (response.statusCode != 200) throw response;
      else {
        CurrentInfo.user!.avatarImage = response.data;
      }
    } on DioException catch (e) {
      throw "Cập nhật avatar thất bại";
    }
    catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> uploadCover(XFile image) async {
    try {
      List<int> bytes = await image.readAsBytes();
      MultipartFile file = MultipartFile.fromBytes(bytes,
          filename: image.name,
          contentType: MediaType("image", image.name.split('.').last));
      FormData formData = FormData.fromMap({'image': file});
      final response = await dio.post(UserApi.postCoverImage(CurrentInfo.user!.id!), data: formData,);
      if (response.statusCode != 200) throw response;
      else {
        CurrentInfo.user!.coverImage = response.data;
      }
    } on DioException catch (e) {
      throw "Cập nhật avatar thất bại";
    }
    catch (e) {
      print(e);
      rethrow;
    }
  }
}