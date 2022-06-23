//https://javiercbk.github.io/json_to_dart/

import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int? id;
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? url;

  Location({
    this.id,
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['region'] = this.region;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['url'] = this.url;
    return data;
  }
}


// "location": {
//         "name": "London",
//         "region": "City of London, Greater London",
//         "country": "United Kingdom",
//         "lat": 51.52,
//         "lon": -0.11,
//         "tz_id": "Europe/London",
//         "localtime_epoch": 1655995689,
//         "localtime": "2022-06-23 15:48"
//     },