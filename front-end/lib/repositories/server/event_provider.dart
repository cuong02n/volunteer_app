import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thien_nguyen_app/configs/server_api.dart';
import 'package:thien_nguyen_app/models/entity/criteria_event.dart';
import 'package:thien_nguyen_app/models/entity/event.dart';
import 'dart:math';

import 'dio.dart';

abstract class EventServerRepository {
  ///Get Fanpage information
  static Future<List<Event>> getEvents(EventCriteria criteria) async {
    //Call response
    try {
      final response = await dio.get(EventApi.getSpecificEvent, queryParameters: criteria.toJson());
      if (response.statusCode == 200) {
        List<Event> result = (response.data as List).map((e) => Event.fromJson(e)).toList();
        result.sort((a, b) => b.startTime!.compareTo(a.startTime!) ?? 0);
        return result;
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

  static Future<void> editEvent(Event data) async {
    try {
      final response = await dio.put(EventApi.putEvent(data.id!), data: data);
      if (response.statusCode != 200) {
        throw response;
      } else {

      }
    } on DioException {
      throw "Chỉnh sửa thông tin thất bại";
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<Event> createEvent(Event data, {XFile? image}) async {
    try {
      final response = await dio.post(EventApi.postNewEvent, data: data);
      if (response.statusCode != 200) throw response;
      else {
        Event event = Event.fromJson(response.data);
        if (image != null) await EventServerRepository.uploadImage(image, event.id!);
        List<Event> newEvents = await EventServerRepository.getEvents(EventCriteria(id: event.id));
        return newEvents.first;
      }
    } on DioException {
      throw "Tạo event thất bại";
    }
    catch (e) {
      rethrow;
    }
  }
  
  static double process(a, b) => (a == null || b == null)?0:a/b;

  static Future<List<Event>> getAllEventByPriority() async {
    List<Event> events = await EventServerRepository.getEvents(EventCriteria());
    events.removeWhere((e) => process(e.progress, e.target) >= 1);
    events.sort((a, b) => process(b.progress, b.target).compareTo(process(a.progress, a.target)));
    return events.sublist(0, min(events.length, 10));
  }

  static Future<void> uploadImage(XFile image, int eventId) async {
    try {
      List<int> bytes = await image.readAsBytes();
      MultipartFile file = MultipartFile.fromBytes(bytes,
          filename: image.name,
          contentType: MediaType("image", image.name.split('.').last));
      FormData formData = FormData.fromMap({'image': file});
      final response = await dio.post(EventApi.updateEventImage(eventId), data: formData,);
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