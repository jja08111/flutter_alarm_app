import 'package:flutter/material.dart';

@immutable
class Alarm {
  /// 7의 배수 중 하나로 된 정수이다.
  final int id;

  /// sun, mon, ... , sat
  final List<bool> weekday;
  final TimeOfDay timeOfDay;
  final bool enabled;

  const Alarm({
    required this.id,
    this.weekday = const [true, true, true, true, true, true, true],
    required this.timeOfDay,
    required this.enabled,
  }) : assert(weekday.length == 7);

  int createCallbackIdWith(int weekday) {
    return id + weekday;
  }

  Alarm copyWith({TimeOfDay? timeOfDay, bool? enabled}) {
    return Alarm(
      id: id,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      enabled: enabled ?? this.enabled,
      weekday: weekday,
    );
  }
}
