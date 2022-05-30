import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/model/alarm.dart';
import 'package:flutter_alarm_app/service/alarm_file_handler.dart';

class AlarmListProvider extends ChangeNotifier {
  AlarmListProvider(this._alarms);

  final AlarmFileHandler _fileHandler = AlarmFileHandler();

  final List<Alarm> _alarms;

  int get length => _alarms.length;

  Alarm operator [](int index) {
    assert(0 <= index && index < _alarms.length);
    return _alarms[index];
  }

  Future<void> _updateFile() async {
    await _fileHandler.write(_alarms);
  }

  void add(Alarm alarm) {
    _alarms.add(alarm);
    _updateFile();
    notifyListeners();
  }

  void remove(Alarm alarm) {
    _alarms.remove(alarm);
    _updateFile();
    notifyListeners();
  }

  void replace(Alarm oldAlarm, Alarm newAlarm) {
    _alarms[_alarms.indexOf(oldAlarm)] = newAlarm;
    _updateFile();
    notifyListeners();
  }

  int getAvailableAlarmId() {
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
