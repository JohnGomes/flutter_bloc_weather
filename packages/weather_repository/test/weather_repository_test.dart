// ignore_for_file: prefer_const_constructors
import 'package:weather_api/weather_api.dart' as weather_api;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherApiClient extends Mock implements weather_api.WeatherApiClient {}

class MockLocation extends Mock implements weather_api.Location {}

class MockWeather extends Mock implements weather_api.Weather {}

class MockCurrent extends Mock implements weather_api.Current {}

void main() {
  group('WeatherRepository', () {
    late weather_api.WeatherApiClient WeatherApiClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      WeatherApiClient = MockWeatherApiClient();
      weatherRepository = WeatherRepository(
        weatherApiClient: WeatherApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal WeatherApiClient when not injected', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('getWeather', () {
      const city = 'london';
      const id = 44418;

      test('calls locationSearch with correct city', () async {
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(() => WeatherApiClient.locationSearch(city)).called(1);
      });

      test('throws when locationSearch fails', () async {
        final exception = Exception('oops');
        when(() => WeatherApiClient.locationSearch(any())).thenThrow(exception);
        expect(
          () async => await weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('calls getWeather with correct id', () async {
        final location = MockLocation();
        when(() => location.id).thenReturn(id);
        when(() => WeatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(() => WeatherApiClient.getWeather(city, id)).called(1);
      });

      test('throws when getWeather fails', () async {
        final exception = Exception('oops');
        final location = MockLocation();
        when(() => location.id).thenReturn(id);
        when(() => WeatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(() => WeatherApiClient.getWeather(any(), any())).thenThrow(exception);
        expect(
          () async => await weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('returns correct weather on success (showers)', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final current = MockCurrent();
        when(() => location.id).thenReturn(id);
        when(() => location.name).thenReturn('London');
        when(() => current.condition).thenReturn(weather_api.Condition(text: "rain"));
        when(() => current.tempF).thenReturn(42.42);
        when(() => weather.current).thenReturn(current);
        when(() => WeatherApiClient.locationSearch(any())).thenAnswer((_) async => location);
        when(() => WeatherApiClient.getWeather(any(), any())).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        expect(
          actual,
          Weather(
            temperature: 42.42,
            location: 'London',
            condition: WeatherCondition.rainy,
          ),
        );
      });

      test('returns correct weather on success (heavy cloud)', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final current = MockCurrent();
        when(() => location.id).thenReturn(id);
        when(() => location.name).thenReturn('London');
        when(() => current.condition).thenReturn(weather_api.Condition(text: "heavy cloud"));
        when(() => current.tempF).thenReturn(42.42);
        when(() => weather.current).thenReturn(current);
        when(() => WeatherApiClient.locationSearch(any())).thenAnswer((_) async => location);
        when(() => WeatherApiClient.getWeather(any(), any())).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        expect(
          actual,
          Weather(
            temperature: 42.42,
            location: 'London',
            condition: WeatherCondition.cloudy,
          ),
        );
      });

      test('returns correct weather on success (light cloud)', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final current = MockCurrent();
        when(() => location.id).thenReturn(id);
        when(() => location.name).thenReturn('London');
        when(() => current.condition).thenReturn(weather_api.Condition(text: "light cloud"));
        when(() => current.tempF).thenReturn(42.42);
        when(() => weather.current).thenReturn(current);
        when(() => WeatherApiClient.locationSearch(any())).thenAnswer((_) async => location);
        when(() => WeatherApiClient.getWeather(any(), any())).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        expect(
          actual,
          Weather(
            temperature: 42.42,
            location: 'London',
            condition: WeatherCondition.cloudy,
          ),
        );
      });
    });
  });
}
