import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/core/utils/classes/storage.dart';
import 'package:weather_app/core/utils/extensions/int_extensions.dart';
import 'package:weather_app/src/app/features/home/pages/home_page.dart';
import 'package:weather_app/src/app/widgets/loading_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  String get route => '/splash';

  initSplashPage(context) async {
    await Storage.init();
    Storage().initUnit();
    try {
      var status = await Permission.location.status;
      if (status != PermissionStatus.granted) {
        await Permission.location.request();
      }
    } catch (e) {
      log(e.toString());
    }

    await 2.delayed();
    Navigator.pushReplacementNamed(context, HomePage.route);
  }

  @override
  Widget build(BuildContext context) {
    initSplashPage(context);
    return const LoadingPage();
  }
}
