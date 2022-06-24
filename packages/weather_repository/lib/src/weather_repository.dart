import 'dart:async';

import 'package:weather_api/weather_api.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart';

class WeatherFailure implements Exception {}

class WeatherRepository {
  WeatherRepository({WeatherApiClient? weatherApiClient}) : _weatherApiClient = weatherApiClient ?? WeatherApiClient();

  final WeatherApiClient _weatherApiClient;

  Future<Weather> getWeather(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final id = location.id;
    final weather = await _weatherApiClient.getWeather(city, id ?? 0);
    return Weather(
      temperature: weather.current?.tempF ?? 0, // weather.theTemp,
      location: location.name ?? "Name not found",
      condition: weather.current?.condition?.toCondition ?? WeatherCondition.unknown,
    );
  }
}

//https://www.weatherapi.com/docs/weather_conditions.json
extension on Condition {
  WeatherCondition get toCondition {
    var text = this.text ?? "";

    if (text.contains('clear')) return WeatherCondition.clear;
    if (text.contains('snow')) return WeatherCondition.snowy;
    if (text.contains('rain')) return WeatherCondition.rainy;
    if (text.contains('cloud')) return WeatherCondition.cloudy;
    return WeatherCondition.unknown;
  }
}
