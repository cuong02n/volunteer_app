import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thien_nguyen_app/configs/server_api.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';

import 'dio.dart';

abstract class FanpageServerRepository {
  ///Get Fanpage information
  static Future<Fanpage> getFanpage(int id) async {
    //Call response
    try {
      final response = await dio.get(FanpageApi.getFanpage(id));
      if (response.statusCode == 200) {
        return Fanpage.fromJson(response.data);
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

  static Future<List<Fanpage>> getAllFanpage(int userId) async {
    //Call response
    try {
      final response = await dio.get(FanpageApi.getAllFanpages, queryParameters: {'userId': userId});
      if (response.statusCode == 200) {
        List<Fanpage> fanpages = (response.data as List).map((e) => Fanpage.fromJson(e)).toList();
        print(fanpages.map((e) => e.toJson()));
        return fanpages;
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

  static Future<void> deleteFanpage(int id) async {
    try {
      final response = await dio.delete(FanpageApi.deleteFanpage(id));
      if (response.statusCode != 200) {
        throw response;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) throw "Không được xóa";
      throw "Lỗi kết nối";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<Fanpage> editFanpage(int id, Fanpage data, {XFile? avatar, XFile? cover}) async {
    try {
      final response = await dio.put(FanpageApi.putFanpage(id), data: data);
      if (response.statusCode != 200) throw response;
      else {
        Fanpage fanpage = Fanpage.fromJson(response.data);
        print(avatar);
        print(cover);
        if (avatar != null) await FanpageServerRepository.uploadAvatar(avatar, fanpage.id!).onError((error, stackTrace) => null);
        if (cover != null) await FanpageServerRepository.uploadCover(cover, fanpage.id!).onError((error, stackTrace) => null);
        return await FanpageServerRepository.getFanpage(fanpage.id!);
      }
    } on DioException {
      throw "Chỉnh sửa thông tin thất bại";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<Fanpage> createFanpage(Fanpage data, {XFile? avatar, XFile? cover}) async {
    try {
      final response = await dio.post(FanpageApi.createFanpage, data: data);
      if (response.statusCode != 200) throw response;
      else {
        Fanpage fanpage = Fanpage.fromJson(response.data);
        print(avatar);
        print(cover);
        if (avatar != null) await FanpageServerRepository.uploadAvatar(avatar, fanpage.id!).onError((error, stackTrace) => null);
        if (cover != null) await FanpageServerRepository.uploadCover(cover, fanpage.id!).onError((error, stackTrace) => null);
        return await FanpageServerRepository.getFanpage(fanpage.id!);
      }
    } on DioException {
      throw "Tạo fanpage thất bại";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<void> uploadAvatar(XFile image, int fanpageId) async {
    try {
      List<int> bytes = await image.readAsBytes();
      MultipartFile file = MultipartFile.fromBytes(bytes,
          filename: image.name,
          contentType: MediaType("image", image.name.split('.').last));
      FormData formData = FormData.fromMap({'image': file});
      final response = await dio.post(FanpageApi.postAvatarImage(fanpageId), data: formData,);
      if (response.statusCode != 200) throw response;
    } on DioException catch (e) {
      throw "Cập nhật avatar thất bại";
    }
    catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> uploadCover(XFile image, int fanpageId) async {
    try {
      List<int> bytes = await image.readAsBytes();
      MultipartFile file = MultipartFile.fromBytes(bytes,
          filename: image.name,
          contentType: MediaType("image", image.name.split('.').last));
      FormData formData = FormData.fromMap({'image': file});
      final response = await dio.post(FanpageApi.postCoverImage(fanpageId), data: formData,);
      if (response.statusCode != 200) throw response;
    } on DioException catch (e) {
      throw "Cập nhật avatar thất bại";
    }
    catch (e) {
      print(e);
      rethrow;
    }
  }
}