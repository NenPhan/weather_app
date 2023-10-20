import 'package:flutter/material.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/widgets/my_text.dart';

class TempertureText extends StatelessWidget {
  const TempertureText({super.key, this.scale = 1, required this.temp});
  final double scale;
  final double temp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MyText(temp % 1 == 0 ? temp.round().toString() : temp.toString(),
                style: textTheme(context).bodyMedium?.copyWith(fontSize: 20 * scale, fontWeight: FontWeight.w400)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText('°C',
                style: textTheme(context)
                    .bodyMedium
                    ?.copyWith(fontSize: 9 * scale, fontWeight: FontWeight.w500, height: 1.5)),
          ],
        ),
      ],
    );
  }
}
