import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/extensions/int_extensions.dart';
import 'package:weather_app/src/app/features/home/pages/home_page.dart';
import 'package:weather_app/src/app/widgets/loading_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  String get route => '/splash';
  initSplashPage(context) async {
    await 3.delayed();
    Navigator.pushReplacementNamed(context, HomePage.route);
  }

  @override
  Widget build(BuildContext context) {
    initSplashPage(context);
    return const LoadingPage();
  }
}
