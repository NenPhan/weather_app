import 'package:flutter/material.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/utils/functions.dart';
import 'package:weather_app/src/app/widgets/popup_select_location.dart';
import 'package:weather_app/src/domain/models/base_mapper.dart';

class SelectLocationButton extends StatelessWidget {
  const SelectLocationButton({super.key, this.location, this.onChanged});
  final Location? location;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showPopUpDialog(context, const SelectLocationPopup(), isCenter: false)
              .then(
            (value) {
              if (value != null && onChanged != null) {
                onChanged!(value);
              }
            },
          );
        },
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (location?.country != null)
                  Text(
                    location?.country ?? '',
                    style: textTheme(context)
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                Text(
                  location?.name ?? 'Select a location',
                  style: textTheme(context)
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
    );
  }
}
