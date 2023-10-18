import 'package:flutter/material.dart';
import 'package:weather_app/core/config/my_theme.dart';

class MyText extends StatelessWidget {
  const MyText(this.text, {super.key, this.style});
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textTheme(context).bodyMedium?.copyWith(
            fontSize: style?.fontSize,
            fontWeight: style?.fontWeight,
            height: style?.height,
            color: style?.color,
          ),
    );
  }
}
