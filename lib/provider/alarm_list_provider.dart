import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/model/alarm.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class AlarmListProvider extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  Future<void> add(Alarm alarm) async {
    _alarms.add(alarm);
    await _oneShot(alarm);
  }

  Future<void> remove(Alarm alarm) async {
    _alarms.remove(alarm);
    await AndroidAlarmManager.cancel(alarm.id);
  }

  Alarm? getAlarmBy(int id) {
    for (Alarm alarm in _alarms) {
      if (alarm.id == id) {
        return alarm;
      }
    }
    return null;
  }

  Future<void> _oneShot(Alarm alarm) async {
    AndroidAlarmManager.oneShotAt(
      alarm.time,
      alarm.id,
      _emptyCallback,
      alarmClock: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  // 이 함수는 최상단에 위치해야 한다. 즉 클래스 내부이면 `static`으로 정의해야 한다.
  static void _emptyCallback() {}
}
