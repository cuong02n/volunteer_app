import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
    headers: headers,
));

Map<String, String> headers = {"Content-Type": "application/json"};