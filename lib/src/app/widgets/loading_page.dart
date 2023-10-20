import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/utils/classes/app_color.dart';
import 'package:weather_app/core/utils/classes/asset.dart';
import 'package:weather_app/core/widgets/sz.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, this.opacity});
  final double? opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity ?? 1,
      child: Scaffold(
        body: Container(
          color: Theme.of(context).extension<AppColors>()!.splashBgr,
          child: Center(
            child: SizedBox(
                width: (scrSize(context).width + scrSize(context).height) /
                    2 *
                    0.4,
                child: Lottie.asset(Assets.lotties.loading)),
          ),
        ),
      ),
    );
  }
}
