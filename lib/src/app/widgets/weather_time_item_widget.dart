import 'package:flutter/material.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/utils/functions.dart';
import 'package:weather_app/core/widgets/my_text.dart';
import 'package:weather_app/src/app/widgets/spacing_widget.dart';
import 'package:weather_app/src/app/widgets/temp_text.dart';
import 'package:weather_app/src/domain/models/base_mapper.dart';

class WeatherTimeItemWidget extends StatelessWidget {
  const WeatherTimeItemWidget({super.key, required this.data});
  final Hour data;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpacingRow(
          spacing: 20,
          children: [
            MyText(
              formatDate(data.time, 'HH:mm a'),
              style: const TextStyle(fontSize: 20),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TempertureText(
                    temp: data.tempC ?? 0,
                    scale: 0.9,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: MyText(
                  '${data.chanceOfRain}%',
                  style: textTheme(context).bodyLarge,
                ),
              ),
            ),
            Image.network('https:${data.condition?.icon ?? ''}', height: 40),
          ],
        ),
      ],
    );
  }
}
