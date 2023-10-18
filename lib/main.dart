import 'package:flutter/material.dart';

import 'core/config/app.dart';
import 'core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    AppConfig(
      appName: 'Weather',
      apiUrl: 'https://',
      logResponse: false,
      child: const MyApp(),
    ),
  );
}
