import 'package:flutter/material.dart';

import 'core/config/app.dart';
import 'core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    AppConfig(
      appName: 'Weather',
      apiUrl: 'https://api.weatherapi.com/v1/',
      apiKey: '8031c2515d3c4a759a3123320231810',
      logResponse: false,
      child: const MyApp(),
    ),
  );
}
