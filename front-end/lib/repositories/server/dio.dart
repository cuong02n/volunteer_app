import 'package:dio/dio.dart';

var _dio = Dio(BaseOptions(
    headers: _headers,
    connectTimeout: const Duration(seconds: 10),
));

Dio get dio => _dio;
final bankDio = Dio();

Map<String, String> _headers = {"Content-Type": "application/json"};

void changeHeader(String key, dynamic value) {
    _headers[key] = value;
    _dio = Dio()..options = (BaseOptions()..headers = _headers);
}

void removeHeader(String key) {
    _headers.remove(key);
    _dio = Dio()..options = (BaseOptions()..headers = _headers);
}