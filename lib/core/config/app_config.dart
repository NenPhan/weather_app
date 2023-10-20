// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:weather_app/core/clients/dio_client.dart';

class AppConfig extends InheritedWidget {
  AppConfig(
      {Key? key,
      required this.appName,
      required this.apiUrl,
      required this.apiKey,
      required Widget child,
      this.logResponse = false})
      : super(key: key, child: child) {
    DioClient().init(apiKey: apiKey, apiUrl: apiUrl);
  }

  final String appName;
  final String apiUrl;
  final String apiKey;
  final bool logResponse;

  static AppConfig? instance(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
