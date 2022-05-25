import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/model/alarm.dart';

class AlarmListProvider extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  int get length => _alarms.length;

  Alarm operator [](int index) {
    assert(0 <= index && index < _alarms.length);
    return _alarms[index];
  }

  // TODO: 실제로 로컬 기기에 저장하기
  void add(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  void remove(Alarm alarm) {
    _alarms.remove(alarm);
    notifyListeners();
  }

  void replace(Alarm oldAlarm, Alarm newAlarm) {
    _alarms[_alarms.indexOf(oldAlarm)] = newAlarm;
    notifyListeners();
  }

  int generateAlarmId() {
    int id = 14;
    for (final alarm in _alarms) {
      if (alarm.id != id) {
        break;
      }
      id = id + 7;
    }
    return id;
  }

  Alarm? getAlarmBy(int callbackId) {
    for (Alarm alarm in _alarms) {
      final id = (callbackId / 7).floor() * 7;

      if (id == alarm.id) {
        return alarm;
      }
    }
    return null;
  }
}
