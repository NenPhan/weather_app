import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/base_bloc/base.dart';
import 'package:weather_app/core/utils/classes/storage.dart';
import 'package:weather_app/src/app/features/home/blocs/home_page_event.dart';
import 'package:weather_app/src/data/weather_datasource.dart';
import 'package:weather_app/src/domain/models/base_mapper.dart';
import 'package:weather_app/src/domain/repositories/weather_repository.dart';

class HomePageBloc extends Bloc<BaseEvent, BaseState> {
  var weatherRepository = WeatherRepository(dataSource: WeatherDataSource());

  int currentDateIndex = 0;
  HomePageBloc() : super(LoadingState()) {
    on<InitDataEvent>((event, emit) async {
      emit(LoadingState());
      var weatherData = await getWeatherData();
      emit(DataLoadedState(data: weatherData));
    });
    on<ChangeDateEvent>((event, emit) async {
      if (state is DataLoadedState) {
        var data = (state as DataLoadedState).data;
        emit(LoadingState());
        currentDateIndex = event.index;
        emit(DataLoadedState(data: data));
      }
    });
    add(InitDataEvent());
  }

  Future<WeatherData> getWeatherData() async {
    var data = WeatherData();
    String? location;

    location = Storage().getCurrentLocation();

    try {
      if (location == null) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        location = '${position.latitude},${position.longitude}';
      }
    } catch (e) {
      location = 'London';
    }
    if (location != null) {
      var response = await weatherRepository.getWeather(location);
      response.fold(
        (l) {
          log(l);
        },
        (r) {
          data = r;
        },
      );
    }
    return data;
  }
}
