// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      id: json['id'] as int,
      weekday:
          (json['weekday'] as List<dynamic>?)?.map((e) => e as bool).toList() ??
              const [true, true, true, true, true, true, true],
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'id': instance.id,
      'weekday': instance.weekday,
      'hour': instance.hour,
      'minute': instance.minute,
      'enabled': instance.enabled,
    };
