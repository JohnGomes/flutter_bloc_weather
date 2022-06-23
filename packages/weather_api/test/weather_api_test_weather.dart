import 'package:weather_api/weather_api.dart';
import 'package:test/test.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      // test(
      //     'returns WeatherState.unknown '
      //     'for unsupported weather_state_abbr', () {
      test('returns normally', () {
        expect(
            Weather.fromJson(<String, dynamic>{
              "location": {"name": "Walworth", "region": "County Durham", "country": "United Kingdom", "lat": 54.56, "lon": -1.64, "tz_id": "Europe/London", "localtime_epoch": 1656013893, "localtime": "2022-06-23 20:51"},
              "current": {
                "last_updated_epoch": 1656012600,
                "last_updated": "2022-06-23 20:30",
                "temp_c": 20.0,
                "temp_f": 68.0,
                "is_day": 1,
                "condition": {"text": "Sunny", "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png", "code": 1000},
                "wind_mph": 4.3,
                "wind_kph": 6.8,
                "wind_degree": 180,
                "wind_dir": "S",
                "pressure_mb": 1006.0,
                "pressure_in": 29.71,
                "precip_mm": 0.0,
                "precip_in": 0.0,
                "humidity": 60,
                "cloud": 0,
                "feelslike_c": 20.0,
                "feelslike_f": 68.0,
                "vis_km": 10.0,
                "vis_miles": 6.0,
                "uv": 4.0,
                "gust_mph": 15.0,
                "gust_kph": 24.1
              }
            }) //,
            // isA<Weather>().having(
            //   (w) => w.weatherStateAbbr,
            //   'abbr',
            //   WeatherState.unknown,
            // ),
            ,
            returnsNormally);
      });
    });

    // group('WeatherStateX', () {
    //   const weatherState = WeatherState.showers;
    //   test('abbr returns correct string abbreviation', () {
    //     expect(weatherState.abbr, 's');
    //   });
    //});
  });
}
