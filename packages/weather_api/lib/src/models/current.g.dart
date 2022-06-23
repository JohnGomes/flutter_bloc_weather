// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'current.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Current _$CurrentFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Current',
      json,
      ($checkedConvert) {
        final val = Current(
          lastUpdatedEpoch:
              $checkedConvert('last_updated_epoch', (v) => v as int?),
          lastUpdated: $checkedConvert('last_updated', (v) => v as String?),
          tempC: $checkedConvert('temp_c', (v) => v as int?),
          tempF: $checkedConvert('temp_f', (v) => v as int?),
          isDay: $checkedConvert('is_day', (v) => v as int?),
          condition: $checkedConvert(
              'condition',
              (v) => v == null
                  ? null
                  : Condition.fromJson(v as Map<String, dynamic>)),
          windMph: $checkedConvert('wind_mph', (v) => (v as num?)?.toDouble()),
          windKph: $checkedConvert('wind_kph', (v) => (v as num?)?.toDouble()),
          windDegree: $checkedConvert('wind_degree', (v) => v as int?),
          windDir: $checkedConvert('wind_dir', (v) => v as String?),
          pressureMb: $checkedConvert('pressure_mb', (v) => v as int?),
          pressureIn:
              $checkedConvert('pressure_in', (v) => (v as num?)?.toDouble()),
          precipMm:
              $checkedConvert('precip_mm', (v) => (v as num?)?.toDouble()),
          precipIn:
              $checkedConvert('precip_in', (v) => (v as num?)?.toDouble()),
          humidity: $checkedConvert('humidity', (v) => v as int?),
          cloud: $checkedConvert('cloud', (v) => v as int?),
          feelslikeC:
              $checkedConvert('feelslike_c', (v) => (v as num?)?.toDouble()),
          feelslikeF:
              $checkedConvert('feelslike_f', (v) => (v as num?)?.toDouble()),
          visKm: $checkedConvert('vis_km', (v) => v as int?),
          visMiles: $checkedConvert('vis_miles', (v) => v as int?),
          uv: $checkedConvert('uv', (v) => v as int?),
          gustMph: $checkedConvert('gust_mph', (v) => (v as num?)?.toDouble()),
          gustKph: $checkedConvert('gust_kph', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'lastUpdatedEpoch': 'last_updated_epoch',
        'lastUpdated': 'last_updated',
        'tempC': 'temp_c',
        'tempF': 'temp_f',
        'isDay': 'is_day',
        'windMph': 'wind_mph',
        'windKph': 'wind_kph',
        'windDegree': 'wind_degree',
        'windDir': 'wind_dir',
        'pressureMb': 'pressure_mb',
        'pressureIn': 'pressure_in',
        'precipMm': 'precip_mm',
        'precipIn': 'precip_in',
        'feelslikeC': 'feelslike_c',
        'feelslikeF': 'feelslike_f',
        'visKm': 'vis_km',
        'visMiles': 'vis_miles',
        'gustMph': 'gust_mph',
        'gustKph': 'gust_kph'
      },
    );
