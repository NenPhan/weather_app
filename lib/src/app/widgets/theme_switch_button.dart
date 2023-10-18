import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/config/my_theme.dart';

class ThemeSwitchButton extends StatefulWidget {
  const ThemeSwitchButton({super.key, this.size = 35});
  final double size;
  @override
  State<ThemeSwitchButton> createState() => _ThemeSwitchButtonState();
}

class _ThemeSwitchButtonState extends State<ThemeSwitchButton> {
  var isDark = false;
  @override
  void initState() {
    isDark = context.read<ThemeCubit>().state == ThemeMode.dark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.read<ThemeCubit>().updateThemeMode();
          isDark = context.read<ThemeCubit>().state == ThemeMode.dark;
          setState(() {});
        },
        icon: Icon(
          isDark ? Icons.dark_mode : Icons.light_mode,
          color: isDark ? Colors.white : Colors.yellow[700],
          size: widget.size,
        ));
  }
}
