import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/utils/classes/asset.dart';
import 'package:weather_app/core/utils/enums.dart';
import 'package:weather_app/core/utils/extensions/int_extensions.dart';
import 'package:weather_app/core/widgets/sz.dart';

class WeatherBackDrop extends StatelessWidget {
  const WeatherBackDrop(
      {super.key, required this.child, this.weatherCondition});
  final Widget child;
  final WeatherCondition? weatherCondition;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //bg1
      Stack(
        children: [
          Container(
            width: scrSize(context).width,
            height: scrSize(context).height,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          if (weatherCondition != null)
            AnimatedPositioned(
              duration: 800.miliSeconds,
              // left: weatherCondition == WeatherCondition.clear
              //     ? -scrSize(context).width * 0.1
              //     : 0,
              // top: 0,
              child: SlideSwitcher(
                child: weatherCondition == WeatherCondition.rain
                    ? Transform.scale(
                        scale: 1.2,
                        child: Lottie.asset(
                          Assets.lotties.rain,
                        ))
                    : weatherCondition == WeatherCondition.cloud
                        ? Transform.scale(
                            scale: 1.2,
                            child: Lottie.asset(
                              Assets.lotties.cloud,
                            ))
                        : weatherCondition == WeatherCondition.thunder
                            ? Transform.scale(
                                scale: 2,
                                child: Lottie.asset(
                                  Assets.lotties.thunder,
                                ))
                            : weatherCondition == WeatherCondition.snow
                                ? Transform.scale(
                                    scale: 1.2,
                                    child: Lottie.asset(
                                      Assets.lotties.snow,
                                    ))
                                : weatherCondition == WeatherCondition.fog
                                    ? Transform.scale(
                                        scale: 1.7,
                                        child: Lottie.asset(
                                          Assets.lotties.fog,
                                        ))
                                    : BlocBuilder(
                                        bloc: context.read<ThemeCubit>(),
                                        builder: (context, state) {
                                          return Container(
                                            key: UniqueKey(),
                                            width:
                                                scrSize(context).height * 0.4,
                                            height:
                                                scrSize(context).height * 0.4,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: state == ThemeMode.dark
                                                    ? const Color.fromARGB(
                                                        153, 188, 242, 255)
                                                    : Colors.yellow[600],
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: state ==
                                                              ThemeMode.dark
                                                          ? const Color
                                                              .fromARGB(153,
                                                              188, 242, 255)
                                                          : Colors.yellow[400]!,
                                                      blurRadius: state ==
                                                              ThemeMode.dark
                                                          ? 1
                                                          : 50,
                                                      spreadRadius: state ==
                                                              ThemeMode.dark
                                                          ? 1
                                                          : 50)
                                                ]),
                                          );
                                        }),
              ),
            ),
          SizedBox(
            width: scrSize(context).width,
            height: scrSize(context).height,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(.25),
                  child: child),
            ),
          ),
        ],
      ),
    ]);
  }
}

class SlideSwitcher extends StatefulWidget {
  const SlideSwitcher({super.key, this.child});

  final Widget? child;

  @override
  State<SlideSwitcher> createState() => _AnimatedLetterState();
}

class _AnimatedLetterState extends State<SlideSwitcher>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  Widget? currentChild;
  Widget? prevChild;
  var offset = 400;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    currentChild = widget.child;
    prevChild = widget.child;
    super.initState();
  }

  @override
  void didUpdateWidget(SlideSwitcher oldWidget) {
    if (widget.child != oldWidget.child) {
      setState(() {
        prevChild = oldWidget.child;
        currentChild = widget.child;
        controller!
          ..reset()
          ..forward();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedBuilder(
          animation: controller!,
          builder: (_, __) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                  offset: Offset(-(controller!.value * offset), 0),
                  child: Visibility(
                    visible: controller!.value < 1,
                    child: Opacity(
                      opacity: 1 - controller!.value,
                      child: prevChild,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(offset - (controller!.value * offset), 0),
                  child: Opacity(
                    opacity: controller!.value,
                    child: currentChild,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
