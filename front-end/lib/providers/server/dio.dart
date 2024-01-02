import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
    headers: {"Content-Type": "application/json"}
));