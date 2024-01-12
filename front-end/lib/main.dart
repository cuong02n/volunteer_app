import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'ui/app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  usePathUrlStrategy();
  runApp(const App());
}