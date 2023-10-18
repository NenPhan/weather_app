import 'package:flutter/material.dart';

sw(double w, {Widget? child}) => SizedBox(
      width: w,
      child: child,
    );
sh(double h, {Widget? child}) => SizedBox(
      height: h,
      child: child,
    );
sz({double? w, double? h, Widget? child}) => SizedBox(
      width: w,
      height: h,
      child: child,
    );

Size scrSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
