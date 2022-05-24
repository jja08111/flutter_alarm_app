import 'package:flutter/material.dart';

class AlarmState extends ChangeNotifier {
  int? get callbackAlarmId => _callbackAlarmId;
  int? _callbackAlarmId;

  bool get isFired => _callbackAlarmId != null;

  void fire(int alarmId) {
    _callbackAlarmId = alarmId;
    notifyListeners();
  }

  void clear() {
    _callbackAlarmId = null;
    notifyListeners();
  }
}
