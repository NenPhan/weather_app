import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/base_bloc/base.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/utils/classes/storage.dart';
import 'package:weather_app/core/utils/enums.dart';
import 'package:weather_app/src/app/features/home/blocs/home_page_event.dart';
import 'package:weather_app/src/data/weather_datasource.dart';
import 'package:weather_app/src/domain/models/base_mapper.dart';
import 'package:weather_app/src/domain/repositories/weather_repository.dart';

class HomePageBloc extends Bloc<BaseEvent, BaseState> {
  var weatherRepository = WeatherRepository(dataSource: WeatherDataSource());

  int currentDateIndex = 0;
  WeatherCondition currentWeatherCondition = WeatherCondition.clear;
  final BuildContext context;
  HomePageBloc(this.context) : super(const LoadingState()) {
    on<InitDataEvent>((event, emit) async {
      emit(LoadingState(
          data: state is DataLoadedState
              ? (state as DataLoadedState).data
              : null));
      currentDateIndex = 0;
      var weatherData = await getWeatherData(newLocation: event.param);
      if (weatherData?.current != null) {
        emit(DataLoadedState(data: weatherData));
      } else {
        emit(const ErrorState());
      }
    });
    on<ChangeDateEvent>((event, emit) async {
      if (state is DataLoadedState) {
        var data = (state as DataLoadedState).data as WeatherData;
        emit(LoadingState(data: data));
        currentDateIndex = event.index;
        updateCurrentWeatherCondition(event.index == 0
            ? (data.current?.condition?.text ?? '')
            : (data.forecast?.forecastday?[event.index].day?.condition?.text ??
                ''));
        emit(DataLoadedState(data: data));
      }
    });
    on<ChangeTempUnit>((event, emit) async {
      if (state is DataLoadedState) {
        var data = (state as DataLoadedState).data as WeatherData;
        emit(LoadingState(data: data));
        Storage().changeUnit();
        emit(DataLoadedState(data: data));
      }
    });
    add(InitDataEvent());
  }

  Future<WeatherData?> getWeatherData({String? newLocation}) async {
    var data = WeatherData();
    String? location;

    if (newLocation == null) {
      //init
      location = Storage().getCurrentLocation();
      try {
        if (location == null) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          location = '${position.latitude},${position.longitude}';
        }
      } catch (e) {
        location = null;
      }
    } else {
      //change location by user
      location = newLocation;
    }

    if (location != null) {
      //* debug another city
      // location = 'Indonesia';
      //* debug wrong input
      // location = 'a';
      var response = await weatherRepository.getWeather(location);
      response.fold(
        (left) {
          log(left);
          return null;
        },
        (right) {
          data = right;

          if (data.location?.name != null && data.location?.country != null) {
            Storage()
                .saveLocation(data.location!.name!, data.location!.country!);
          }
          updateCurrentWeatherCondition(data.current?.condition?.text ?? '');
          if (data.location?.localtime != null) {
            bool isDark = data.location!.localtime!.isBefore(
                data.location!.localtime!.copyWith(hour: 6, minute: 0));
            if (isDark == false) {
              isDark = data.location!.localtime!.isAfter(
                  data.location!.localtime!.copyWith(hour: 18, minute: 0));
            }
            context.read<ThemeCubit>().updateThemeMode(isDark);
          }
        },
      );
    }
    return data;
  }

  updateCurrentWeatherCondition(String condition) {
    if (['thunder'].any(
      (e) => condition.toLowerCase().contains(e),
    )) {
      currentWeatherCondition = WeatherCondition.thunder;
    } else if (['rain', 'drizzle', 'sleet'].any(
      (e) => condition.toLowerCase().contains(e),
    )) {
      currentWeatherCondition = WeatherCondition.rain;
    } else if (['snow', 'ice', 'blizzard'].any(
      (e) => condition.toLowerCase().contains(e),
    )) {
      currentWeatherCondition = WeatherCondition.snow;
    } else if (['fog', 'mist', 'overcast'].any(
      (e) => condition.toLowerCase().contains(e),
    )) {
      currentWeatherCondition = WeatherCondition.fog;
    } else if (['cloudy'].any(
      (e) => condition.toLowerCase().contains(e),
    )) {
      currentWeatherCondition = WeatherCondition.cloud;
    } else {
      currentWeatherCondition = WeatherCondition.clear;
    }
  }
}
