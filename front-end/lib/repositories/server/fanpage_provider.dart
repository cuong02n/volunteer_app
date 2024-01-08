import 'package:dio/dio.dart';
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
        return (response.data as List).map((e) => Fanpage.fromJson(e)).toList();
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
      final response = await dio.get(FanpageApi.deleteFanpage(id));
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

  static Future<void> editFanpage(Fanpage data) async {
    try {
      final response = await dio.put(FanpageApi.putFanpage(data.id!), data: data);
      if (response.statusCode != 200) throw response;
      else {

      }
    } on DioException {
      throw "Chỉnh sửa thông tin thất bại";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<Fanpage> createFanpage(Fanpage data) async {
    try {
      final response = await dio.post(FanpageApi.createFanpage, data: data);
      if (response.statusCode != 200) throw response;
      else {
        return Fanpage.fromJson(response.data);
      }
    } on DioException {
      throw "Tạo fanpage thất bại";
    }
    catch (e) {
      rethrow;
    }
  }
}