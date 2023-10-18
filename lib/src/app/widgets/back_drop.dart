import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/widgets/sz.dart';

class BackDrop extends StatefulWidget {
  const BackDrop({super.key, required this.child});
  final Widget child;

  @override
  State<BackDrop> createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop> {
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
          Positioned(
            left: -100,
            top: scrSize(context).height / 3,
            child: SlideSwitcher(
              child:
                  // Container(
                  //   key: UniqueKey(),
                  //   width: 400,
                  //   height: 400,
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.yellow[600],
                  //       boxShadow: [BoxShadow(color: Colors.yellow[400]!, blurRadius: 100, spreadRadius: 1)]),
                  // ),
                  Lottie.asset(name),
            ),
          ),
          SizedBox(
            width: scrSize(context).width,
            height: scrSize(context).height,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: widget.child,
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

class _AnimatedLetterState extends State<SlideSwitcher> with SingleTickerProviderStateMixin {
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
