import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/config/app_config.dart';

disableFocus(BuildContext context) async {
  if (AppConfig.instance(context)?.overlayEntry.mounted ?? false) {
    AppConfig.instance(context)?.overlayEntry.remove();
  }
}

String formatDate(DateTime? date, [String formatString = 'dd/MM/yyyy']) {
  return date == null ? '' : DateFormat(formatString).format(date);
}
