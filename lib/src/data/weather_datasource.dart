import 'package:weather_app/core/clients/dio_client.dart';
import 'package:weather_app/core/utils/enums.dart';
import 'package:weather_app/src/domain/models/base_mapper.dart';

abstract class IWeatherDataSource {
  Future<WeatherData> getWeather(String location);
}

class WeatherDataSource extends IWeatherDataSource {
  @override
  Future<WeatherData> getWeather(String location) async {
    try {
      final response = await DioClient().call(
          DioParams(HttpMethod.GET, endpoint: 'forecast.json', params: {'q': location, 'days': 10, 'aqi': 'yes'}));
      return WeatherData.fromJson(response);
    } catch (e) {
      throw 'Server Error';
    }
  }
}
