// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({Key? key, required this.appName, required this.apiUrl, required Widget child, this.logResponse = false})
      : super(key: key, child: child);

  final String appName;
  final String apiUrl;
  final bool logResponse;
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => const SizedBox(),
  );

  static AppConfig? instance(BuildContext context) => context.dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
