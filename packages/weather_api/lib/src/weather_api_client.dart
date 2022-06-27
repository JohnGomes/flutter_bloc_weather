import 'dart:async';
import 'dart:convert';
import 'package:weather_api/secrets.dart' as secrets;

import 'package:http/http.dart' as http;
import 'package:weather_api/weather_api.dart';

/// Exception thrown when locationSearch fails.
class LocationIdRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

/// {@template weather_api_client}
/// Dart API Client which wraps the [Weather API](http://api.weatherapi.com/v1/).
/// {@endtemplate}
class WeatherApiClient {
  /// {@macro weather_api_client}
  WeatherApiClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'api.weatherapi.com';
  static const _api_key = secrets.weather_api_key;
  final http.Client _httpClient;

  /// Finds a [Location] `search.json?key=(key)&q=(query)`.
  Future<Location> locationSearch(String locationName) async {
    final locationRequest = Uri.https(
      _baseUrl,
      '/v1/search.json',
      <String, String>{'key': _api_key, 'q': locationName},
    );
    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationIdRequestFailure();
    }

    final locationJson = jsonDecode(
      locationResponse.body, //TODO get the fist location -- double check this
    ) as List;

    if (locationJson.isEmpty) {
      throw LocationNotFoundFailure();
    }

    return Location.fromJson(locationJson.first as Map<String, dynamic>);
  }

  /// Fetches [Weather] for a given [locationId].
  Future<Weather> getWeather(String locationName, int locationId) async {
    final weatherRequest = Uri.https(
      _baseUrl,
      '/v1/current.json',
      <String, String>{'key': _api_key, 'q': locationName},
    );
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson;

    if (weatherJson == null) {
      throw WeatherNotFoundFailure();
    }

    return Weather.fromJson(weatherJson);
  }
}
