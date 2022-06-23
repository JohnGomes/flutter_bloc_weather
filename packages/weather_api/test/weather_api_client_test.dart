// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:weather_api/weather_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_api/secrets.dart' as secrets;

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('WeatherApiClient', () {
    late http.Client httpClient;
    late WeatherApiClient weatherApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      weatherApiClient = WeatherApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(WeatherApiClient(), isNotNull);
      });
    });

    group('locationSearch', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await weatherApiClient.locationSearch(query);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.weatherapi.com',
              '/v1/search.json',
              <String, String>{'key': secrets.weather_api_key, 'q': query},
            ),
          ),
        ).called(1);
      });

      test('throws LocationIdRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient.locationSearch(query),
          throwsA(isA<LocationIdRequestFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          weatherApiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('returns Location on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''[{
            "name": "mock-title",
            "region": "region",
            "country": "country",
            "lat": 1.0,
            "lon": 2.0,
            "url": "url",
            "id": 42
          }]''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await weatherApiClient.locationSearch(query);
        expect(
          actual,
          isA<Location>()
              .having(
                (l) => l.name,
                'name',
                'mock-title',
              )
              .having(
                (l) => l.region,
                'region',
                'region',
              )
              .having(
                (l) => l.country,
                'country',
                'country',
              )
              .having(
                (l) => l.lat,
                'lat',
                1.0,
              )
              .having(
                (l) => l.lon,
                'lon',
                2.0,
              )
              .having(
                (l) => l.url,
                'url',
                'url',
              )
              .having(
                (l) => l.id,
                'id',
                42,
              ),
        );
      });
    });

    group('getWeather', () {
      const locationId = 42;
      const locationName = 'London';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await weatherApiClient.getWeather(locationName, locationId);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.weatherapi.com',
              '/v1/current.json',
              <String, String>{'key': secrets.weather_api_key, 'q': locationName},
            ),
          ),
        ).called(1);
      });

      test('throws WeatherRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient.getWeather(locationName, locationId),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient.getWeather(locationName, locationId),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty consolidated weather', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"consolidated_weather": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await weatherApiClient.getWeather(locationName, locationId),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });

      // test('returns weather on valid response', () async {
      //   final response = MockResponse();
      //   when(() => response.statusCode).thenReturn(200);
      //   when(() => response.body).thenReturn('''
      //     {"consolidated_weather":[{
      //       "id":4907479830888448,
      //       "weather_state_name":"Showers",
      //       "weather_state_abbr":"s",
      //       "wind_direction_compass":"SW",
      //       "created":"2020-10-26T00:20:01.840132Z",
      //       "applicable_date":"2020-10-26",
      //       "min_temp":7.9399999999999995,
      //       "max_temp":13.239999999999998,
      //       "the_temp":12.825,
      //       "wind_speed":7.876886316914553,
      //       "wind_direction":246.17046093256732,
      //       "air_pressure":997.0,
      //       "humidity":73,
      //       "visibility":11.037727173307882,
      //       "predictability":73
      //     }]}
      //   ''');
      //   when(() => httpClient.get(any())).thenAnswer((_) async => response);
      //   final actual = await weatherApiClient.getWeather(locationId);
      //   expect(
      //     actual,
      //     isA<Weather>().having((w) => w.id, 'id', 4907479830888448).having((w) => w.weatherStateName, 'state', 'Showers').having((w) => w.weatherStateAbbr, 'abbr', WeatherState.showers).having((w) => w.windDirectionCompass, 'wind', WindDirectionCompass.southWest).having((w) => w.created, 'created', DateTime.parse('2020-10-26T00:20:01.840132Z')).having((w) => w.applicableDate, 'applicableDate', DateTime.parse('2020-10-26')).having((w) => w.minTemp, 'minTemp', 7.9399999999999995).having((w) => w.maxTemp, 'maxTemp', 13.239999999999998).having((w) => w.theTemp, 'theTemp', 12.825).having((w) => w.windSpeed, 'windSpeed', 7.876886316914553).having((w) => w.windDirection, 'windDirection', 246.17046093256732).having((w) => w.airPressure, 'airPressure', 997.0).having((w) => w.humidity, 'humidity', 73).having((w) => w.visibility, 'visibility', 11.037727173307882).having((w) => w.predictability, 'predictability', 73),
      //   );
      // });
    });
  });
}
