import 'package:flutter/material.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/utils/classes/storage.dart';
import 'package:weather_app/core/widgets/my_text.dart';

class TemperatureUnitButton extends StatelessWidget {
  const TemperatureUnitButton({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.3),
            borderRadius: BorderRadius.circular(10)),
        child: MyText(
          Storage().isCelsius() ? '°C' : '°F',
          style: textTheme(context).titleMedium,
        ),
      ),
    );
  }
}
