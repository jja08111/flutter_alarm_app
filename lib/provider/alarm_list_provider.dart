import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/model/alarm.dart';

class AlarmListProvider extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  int get length => _alarms.length;

  Alarm operator [](int index) {
    assert(0 <= index && index < _alarms.length);
    return _alarms[index];
  }

  void add(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  void remove(Alarm alarm) {
    _alarms.remove(alarm);
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
