import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? splashBgr;
  const AppColors({
    required this.splashBgr,
  });
  @override
  AppColors copyWith({
    Color? splashBgr,
    Color? color2,
    Color? color3,
  }) {
    return AppColors(
      splashBgr: splashBgr ?? this.splashBgr,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      splashBgr: Color.lerp(splashBgr, other.splashBgr, t),
    );
  }
}
