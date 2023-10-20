import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/base_bloc/base.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/widgets/sz.dart';
import 'package:weather_app/src/app/features/home/blocs/home_page_event.dart';
import 'package:weather_app/src/app/widgets/back_drop.dart';
import 'package:weather_app/src/app/widgets/loading_page.dart';
import 'package:weather_app/src/app/widgets/temp_text.dart';
import 'package:weather_app/src/app/widgets/theme_switch_button.dart';
import 'package:weather_app/src/app/widgets/spacing_widget.dart';
import 'package:weather_app/src/app/widgets/weather_date_item_widget.dart';
import 'package:weather_app/src/app/widgets/weather_time_item_widget.dart';
import 'package:weather_app/src/domain/models/base_mapper.dart';

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
          if (state is! DataLoadedState) return const LoadingPage();
          var weatherData = state.data as WeatherData;
          return BackDrop(
            weatherCondition: weatherData.current?.condition?.text ?? '',
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.3),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(scrSize(context).width * 0.05),
                  child: SpacingColumn(
                    // spacing: scrSize(context).height * 0.01,
                    children: [
                      //*country name, city name
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weatherData.location?.country ?? '',
                                style: textTheme(context).titleSmall?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                weatherData.location?.name ?? '',
                                style: textTheme(context).titleMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const IgnorePointer(ignoring: true, child: ThemeSwitchButton()),
                        ],
                      ),
                      //*Now Temperature
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TempertureText(
                            temp: weatherData.current?.tempC ?? 0,
                            scale: 7,
                          ),
                        ],
                      ),

                      //*List forecast days
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SpacingRow(
                                spacing: scrSize(context).width * 0.02,
                                children: List.generate(weatherData.forecast?.forecastday?.length ?? 0, (index) {
                                  //*date item
                                  return WeatherDateItemWidget(
                                    isSelected: index == bloc.currentDateIndex,
                                    data: weatherData.forecast?.forecastday?[index] ?? ForecastDay(),
                                    onTap: () {
                                      bloc.add(ChangeDateEvent(index));
                                    },
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      sh(10),
                      //*List weather time of forecast days
                      Expanded(
                        flex: 3,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: scrSize(context).width * 0.02),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.1),
                                border: Border.all(
                                    width: 0.2, color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Scrollbar(
                              interactive: true,
                              thickness: 4,
                              radius: const Radius.circular(10),
                              child: ListView.builder(
                                itemCount: weatherData.forecast?.forecastday?[bloc.currentDateIndex].hour?.length ?? 0,
                                itemBuilder: (context, index) {
                                  //*time item
                                  return Container(
                                    height: scrSize(context).height * 0.1,
                                    // padding: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: index == 0
                                                ? BorderSide.none
                                                : BorderSide(
                                                    color: textTheme(context).bodyMedium?.color ?? Colors.grey,
                                                    width: 0.3))),
                                    child: WeatherTimeItemWidget(
                                        data: weatherData.forecast?.forecastday?[bloc.currentDateIndex].hour?[index] ??
                                            Hour()),
                                  );
                                },
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
