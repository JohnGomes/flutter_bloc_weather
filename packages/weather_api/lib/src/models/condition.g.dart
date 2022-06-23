// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Condition _$ConditionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Condition',
      json,
      ($checkedConvert) {
        final val = Condition(
          text: $checkedConvert('text', (v) => v as String?),
          icon: $checkedConvert('icon', (v) => v as String?),
          code: $checkedConvert('code', (v) => v as int?),
        );
        return val;
      },
    );
