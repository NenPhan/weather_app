import 'package:flutter/material.dart';

class MyColor {
  static Color fromHex(int hex) => Color(hex);
  static get mainColor => const Color(0xff291b12);
  static get mainColorList => [
        const Color(0xff464fb3),
        const Color(0xfffd4632),
        const Color(0xff2a7a76),
        const Color(0xfffdba3d),
      ];
  static get bgr1 => const Color(0xffffffff);
  static get bgr1Dark => Colors.grey[900];
  static get bgr2 => const Color(0xfff3f1ed);
  static get bgr2Dark => const Color(0xff665b45);
  static get textLight => const Color(0xffffffff);
  static get textDark => const Color(0xff291b12);
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
