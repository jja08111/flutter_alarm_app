import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm.g.dart';

@JsonSerializable()
@immutable
class Alarm {
  /// 7의 배수 중 하나로 된 정수이다.
  final int id;

  /// sun, mon, ... , sat
  final List<bool> weekday;

  final int hour;
  final int minute;
  final bool enabled;

  const Alarm({
    required this.id,
    this.weekday = const [true, true, true, true, true, true, true],
    required this.hour,
    required this.minute,
    required this.enabled,
  })  : assert(0 <= hour && hour < 24),
        assert(0 <= minute && minute < 60),
        assert(weekday.length == 7);

  int callbackIdOf(int weekday) {
    return id + weekday;
  }

  Alarm copyWith({int? hour, int? minute, bool? enabled}) {
    return Alarm(
      id: id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      enabled: enabled ?? this.enabled,
      weekday: weekday,
    );
  }

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmToJson(this);
}
