import 'package:json_annotation/json_annotation.dart';
import 'package:weather_api/weather_api.dart';
import 'package:test/test.dart';

void main() {
  group('Location', () {
    group('fromJson', () {
      test('returns normally', () {
        //test('throws CheckedFromJsonException when enum is unknown', () {
        expect(
          () => Location.fromJson(<String, dynamic>{"id": 2817832, "name": "Walworth", "region": "Southwark, Greater London", "country": "United Kingdom", "lat": 51.49, "lon": -0.09, "url": "walworth-southwark-greater-london-united-kingdom"}),
          returnsNormally,
        );
        //throwsA(isA<CheckedFromJsonException>()),
      });
    });
  });
}
