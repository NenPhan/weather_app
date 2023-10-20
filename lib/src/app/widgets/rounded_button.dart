import 'package:flutter/material.dart';
import 'package:weather_app/core/config/my_theme.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      this.width,
      this.height,
      this.onTap,
      this.padding,
      required this.text});
  final double? width, height;
  final Function()? onTap;
  final EdgeInsets? padding;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      splashColor: Colors.transparent,
      height: height ?? 35,
      elevation: 0,
      color: Colors.blue,
      onPressed: onTap ?? () {},
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: textTheme(context).bodyMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
