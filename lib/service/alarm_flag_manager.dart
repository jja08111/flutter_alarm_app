import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmFlagManager {
  static final AlarmFlagManager _instance = AlarmFlagManager._();

  factory AlarmFlagManager() => _instance;

  AlarmFlagManager._();

  @visibleForTesting
  static const String alarmFlagKey = "alarmFlagKey";

  Future<int?> getFiredId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs.getInt(alarmFlagKey);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(alarmFlagKey);
  }
}
