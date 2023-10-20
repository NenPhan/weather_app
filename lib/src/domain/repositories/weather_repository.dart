import 'package:dartz/dartz.dart';
import 'package:weather_app/src/data/weather_datasource.dart';
import 'package:weather_app/src/domain/models/base_mapper.dart';

abstract class IWeatherRepository {
  Future<Either<String, WeatherData>> getWeather(String location);
}

class WeatherRepository extends IWeatherRepository {
  final IWeatherDataSource dataSource;

  WeatherRepository({required this.dataSource});
  @override
  Future<Either<String, WeatherData>> getWeather(String location) async {
    try {
      var value = await dataSource.getWeather(location);
      return Right(value);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
