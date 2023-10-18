import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base_bloc/base.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/widgets/my_text.dart';
import 'package:weather_app/core/widgets/sz.dart';
import 'package:weather_app/src/app/widgets/back_drop.dart';
import 'package:weather_app/src/app/widgets/loading_page.dart';
import 'package:weather_app/src/app/widgets/theme_switch_button.dart';
import 'package:weather_app/src/app/widgets/spacing_widget.dart';

import '../blocs/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String get route => '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc bloc = HomePageBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return state is DataLoadedState
              ? BackDrop(
                  child: Scaffold(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.3),
                    body: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(scrSize(context).width * 0.05),
                        child: SpacingColumn(
                          spacing: scrSize(context).height * 0.02,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Welcome!',
                                  style: textTheme(context).titleLarge?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const Spacer(),
                                const ThemeSwitchButton(),
                              ],
                            ),
                            sh(50),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                sw(40),
                                MyText('30',
                                    style: textTheme(context)
                                        .bodyMedium
                                        ?.copyWith(fontSize: 200, fontWeight: FontWeight.w400, height: 0.9)),
                                MyText('o',
                                    style: textTheme(context)
                                        .bodyMedium
                                        ?.copyWith(fontSize: 30, fontWeight: FontWeight.w400, height: 0.9)),
                                MyText('C',
                                    style: textTheme(context)
                                        .bodyMedium
                                        ?.copyWith(fontSize: 40, fontWeight: FontWeight.w400, height: 0.9)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const LoadingPage();
        });
  }
}
