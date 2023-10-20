import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/widgets/sz.dart';

disableFocus(BuildContext context) async {
  FocusManager.instance.primaryFocus?.unfocus();
}

String formatDate(DateTime? date, [String formatString = 'dd/MM/yyyy']) {
  return date == null ? '' : DateFormat(formatString).format(date);
}

Future showPopUpDialog(BuildContext context, Widget child,
    {bool? useRootNavigator = false,
    bool barrierDismissible = true,
    bool isCenter = true,
    Color? barrierColor,
    double? width,
    double? height}) async {
  var size = MediaQuery.of(context).size;
  return await showGeneralDialog(
      useRootNavigator: useRootNavigator!,
      barrierColor: barrierColor ??
          (context.read<ThemeCubit>().state == ThemeMode.dark
              ? Colors.white.withOpacity(.2)
              : Colors.black.withOpacity(.3)),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value < size.width ? a1.value : size.width,
          child: Opacity(
              opacity: a1.value,
              child: isCenter
                  ? Center(
                      child: Container(
                          width: width ?? size.width * .9,
                          height: height ?? size.height * .6,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: child))
                  : SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          sh(size.height * .1),
                          Container(
                              width: width ?? size.width * .9,
                              height: height ?? size.height * .6,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: child)
                        ],
                      ),
                    )),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      });
}
