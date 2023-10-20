import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/classes/app_color.dart';
import 'package:weather_app/core/utils/classes/my_color.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final bool systemDark;
  ThemeCubit(this.systemDark)
      : super(systemDark ? ThemeMode.dark : ThemeMode.light) {
    updateStatusBarTheme();
  }

  updateThemeMode([bool? isDark]) {
    if (isDark != null) {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } else {
      emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    }
    updateStatusBarTheme();
  }

  updateStatusBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          state == ThemeMode.dark ? MyColor.mainColor : MyColor.bgr1,
      statusBarIconBrightness:
          state == ThemeMode.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          state == ThemeMode.dark ? MyColor.mainColor : MyColor.bgr1,
      systemNavigationBarIconBrightness:
          state == ThemeMode.dark ? Brightness.light : Brightness.dark,
    ));
  }
}

TextTheme textTheme(context) => Theme.of(context).textTheme;
ThemeData theme(context) => Theme.of(context);

class MyThemes {
  static final darkTheme = ThemeData.dark().copyWith(
    // primarySwatch: getMaterialColor(MyColor.mainColorList[0]),
    primaryColor: MyColor.mainColor,
    scaffoldBackgroundColor: MyColor.bgr1Dark,
    cardColor: MyColor.bgr2Dark,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColor.mainColorList[0],
          statusBarIconBrightness: Brightness.light),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    extensions: [AppColors(splashBgr: MyColor.bgr1Dark)],
  );

  static final lightTheme = ThemeData.light().copyWith(
    // primarySwatch: getMaterialColor(MyColor.mainColor),
    primaryColor: MyColor.mainColor,
    scaffoldBackgroundColor: MyColor.bgr1,
    cardColor: MyColor.bgr2,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColor.bgr1,
          statusBarIconBrightness: Brightness.dark),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: MyColor.mainColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyColor.mainColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: MyColor.mainColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: MyColor.mainColor,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: MyColor.mainColor,
      ),
      titleLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: MyColor.mainColor,
      ),
    ),
    extensions: [AppColors(splashBgr: MyColor.bgr1)],
  );
}
