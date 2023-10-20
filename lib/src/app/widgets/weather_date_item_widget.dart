import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/functions.dart';
import 'package:weather_app/core/widgets/my_text.dart';
import 'package:weather_app/core/widgets/sz.dart';
import 'package:weather_app/src/app/widgets/spacing_widget.dart';
import 'package:weather_app/src/app/widgets/temp_text.dart';
import 'package:weather_app/src/domain/models/base_mapper.dart';

class WeatherDateItemWidget extends StatelessWidget {
  const WeatherDateItemWidget(
      {super.key, required this.data, this.onTap, this.isSelected = false});
  final ForecastDay data;
  final Function? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var isToday = false;
    if (formatDate(data.date, 'dd/MM/yyyy') ==
        formatDate(DateTime.now(), 'dd/MM/yyyy')) isToday = true;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        // width: 100,
        height: scrSize(context).height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.withOpacity(.5)
                : Colors.grey.withOpacity(.1),
            border: Border.all(
                width: isToday ? 1 : 0.2,
                color: isToday
                    ? Colors.blue
                    : Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(.5) ??
                        Colors.grey.withOpacity(.5)),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: SpacingColumn(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              formatDate(data.date, 'dd/MM'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TempertureText(
                  temp: data.day?.avgTemp ?? 0,
                  scale: 0.7,
                ),
                Image.network('https:${data.day?.condition?.icon ?? ''}',
                    height: 40),
              ],
            )
          ],
        )),
      ),
    );
  }
}
