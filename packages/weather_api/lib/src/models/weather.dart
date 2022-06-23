import 'package:json_annotation/json_annotation.dart';
import 'package:weather_api/src/models/location.dart';
import 'package:weather_api/src/models/current.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final Location? location;
  final Current? current;

  Weather({this.location, this.current});

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    return data;
  }
}

// class Location {
//   String? name;
//   String? region;
//   String? country;
//   double? lat;
//   double? lon;
//   String? tzId;
//   int? localtimeEpoch;
//   String? localtime;

//   Location({this.name, this.region, this.country, this.lat, this.lon, this.tzId, this.localtimeEpoch, this.localtime});

//   Location.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     region = json['region'];
//     country = json['country'];
//     lat = json['lat'];
//     lon = json['lon'];
//     tzId = json['tz_id'];
//     localtimeEpoch = json['localtime_epoch'];
//     localtime = json['localtime'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['region'] = this.region;
//     data['country'] = this.country;
//     data['lat'] = this.lat;
//     data['lon'] = this.lon;
//     data['tz_id'] = this.tzId;
//     data['localtime_epoch'] = this.localtimeEpoch;
//     data['localtime'] = this.localtime;
//     return data;
//   }
// }




// {
//     "location": {
//         "name": "London",
//         "region": "City of London, Greater London",
//         "country": "United Kingdom",
//         "lat": 51.52,
//         "lon": -0.11,
//         "tz_id": "Europe/London",
//         "localtime_epoch": 1655999994,
//         "localtime": "2022-06-23 16:59"
//     },
//     "current": {
//         "last_updated_epoch": 1655999100,
//         "last_updated": "2022-06-23 16:45",
//         "temp_c": 25,
//         "temp_f": 77,
//         "is_day": 1,
//         "condition": {
//             "text": "Sunny",
//             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
//             "code": 1000
//         },
//         "wind_mph": 4.3,
//         "wind_kph": 6.8,
//         "wind_degree": 70,
//         "wind_dir": "ENE",
//         "pressure_mb": 1007,
//         "pressure_in": 29.74,
//         "precip_mm": 0.4,
//         "precip_in": 0.02,
//         "humidity": 41,
//         "cloud": 0,
//         "feelslike_c": 25.8,
//         "feelslike_f": 78.4,
//         "vis_km": 10,
//         "vis_miles": 6,
//         "uv": 5,
//         "gust_mph": 1.1,
//         "gust_kph": 1.8
//     }
// }