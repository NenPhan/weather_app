import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base_bloc/bloc_observer.dart';

import 'core/config/app.dart';
import 'core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = CustomBlocObserver();

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
