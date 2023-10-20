part of mapper;

@JsonSerializable(createToJson: false)
class WeatherData {
  final Location? location;
  final Current? current;
  final Forecast? forecast;

  WeatherData({this.location, this.current, this.forecast});

  factory WeatherData.fromJson(Map<String, dynamic> json) => _$WeatherDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class Location {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  @JsonKey(name: 'tz_id')
  final String? tzId;
  @JsonKey(name: 'localtime_epoch')
  final int? localtimeEpoch;
  final String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}

@JsonSerializable(createToJson: false)
class Current {
  @JsonKey(name: 'temp_c')
  final double? tempC;
  @JsonKey(name: 'temp_f')
  final double? tempF;
  final Condition? condition;
  @JsonKey(name: 'feelslike_c')
  final double? feelslikeC;
  @JsonKey(name: 'feelslike_f')
  final double? feelslikeF;
  @JsonKey(name: 'maxtemp_c')
  final double? maxtempC;
  @JsonKey(name: 'maxtemp_f')
  final double? maxtempF;
  @JsonKey(name: 'mintemp_c')
  final double? mintempC;
  @JsonKey(name: 'mintemp_f')
  final double? mintempF;
  @JsonKey(name: 'avgtemp_c')
  final double? avgtempC;
  @JsonKey(name: 'avgtemp_f')
  final double? avgtempF;
  final double? uv;
  @JsonKey(name: 'air_quality')
  final AirQuality? airQuality;

  Current({
    this.tempC,
    this.tempF,
    this.condition,
    this.feelslikeC,
    this.feelslikeF,
    this.uv,
    this.airQuality,
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
  });

  factory Current.fromJson(Map<String, dynamic> json) => _$CurrentFromJson(json);
}

@JsonSerializable(createToJson: false)
class Condition {
  final String? text;
  final String? icon;

  Condition({
    this.text,
    this.icon,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);
}

@JsonSerializable(createToJson: false)
class AirQuality {
  final double? co;
  final double? no2;
  final double? o3;
  final double? so2;
  @JsonKey(name: 'pm2_5')
  final double? pm25;
  final double? pm10;
  @JsonKey(name: 'us-epa-index')
  final int? usEpaIndex;
  @JsonKey(name: 'gb-defra-index')
  final int? gbDefraIndex;

  AirQuality({
    this.co,
    this.no2,
    this.o3,
    this.so2,
    this.pm25,
    this.pm10,
    this.usEpaIndex,
    this.gbDefraIndex,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) => _$AirQualityFromJson(json);
}

@JsonSerializable(createToJson: false)
class Forecast {
  final List<ForecastDay>? forecastday;

  Forecast({
    this.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);
}

@JsonSerializable(createToJson: false)
class ForecastDay {
  final DateTime? date;
  @JsonKey(name: 'date_epoch')
  final int? dateEpoch;
  final Current? day;
  final Astro? astro;
  final List<Hour>? hour;

  ForecastDay({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => _$ForecastDayFromJson(json);
}

@JsonSerializable(createToJson: false)
class Astro {
  final String? sunrise;
  final String? sunset;
  @JsonKey(name: 'is_sun_up')
  final int? isSunUp;

  Astro({
    this.sunrise,
    this.sunset,
    this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => _$AstroFromJson(json);
}

@JsonSerializable(createToJson: false)
class Hour {
  @JsonKey(name: 'time_epoch')
  final int? timeEpoch;
  final DateTime? time;
  @JsonKey(name: 'temp_c')
  final double? tempC;
  @JsonKey(name: 'temp_f')
  final double? tempF;
  final Condition? condition;
  final int? humidity;
  final int? cloud;
  @JsonKey(name: 'feelslike_c')
  final double? feelslikeC;
  @JsonKey(name: 'feelslike_f')
  final double? feelslikeF;
  @JsonKey(name: 'will_it_rain')
  final int? willItRain;
  @JsonKey(name: 'chance_of_rain')
  final int? chanceOfRain;
  @JsonKey(name: 'will_it_snow')
  final int? willItSnow;
  @JsonKey(name: 'chance_of_snow')
  final int? chanceOfSnow;
  final double? uv;
  @JsonKey(name: 'air_quality')
  final AirQuality? airQuality;

  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.condition,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.uv,
    this.airQuality,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => _$HourFromJson(json);
}
