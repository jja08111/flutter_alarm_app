import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/model/alarm.dart';

class AlarmScheduler {
  static Future<void> scheduleRepeatable(Alarm alarm) async {
    // sun, mon, ... , sat
    for (int weekday = 0; weekday < 7; ++weekday) {
      if (alarm.weekday[weekday]) {
        final callbackId = alarm.callbackIdOf(weekday);
        final time = alarm.timeOfDay.toComingDateTimeAt(weekday);

        await _oneShot(callbackId, time);
        debugPrint('Alarm scheduled at $time');
      }
    }
  }

  static Future<void> cancelRepeatable(Alarm alarm) async {
    // sun, mon, ... , sat
    for (int weekday = 0; weekday < 7; ++weekday) {
      if (alarm.weekday[weekday]) {
        final callbackId = alarm.callbackIdOf(weekday);

        await AndroidAlarmManager.cancel(callbackId);
        debugPrint('#$callbackId alarm canceled');
      }
    }
  }

  static Future<void> reschedule(int callbackId, DateTime time) async {
    await AndroidAlarmManager.cancel(callbackId);
    await _oneShot(callbackId, time);
    debugPrint('Rescheduled #$callbackId alarm at $time');
  }

  static Future<void> _oneShot(int id, DateTime time) async {
    await AndroidAlarmManager.oneShotAt(
      time,
      id,
      _emptyCallback,
      alarmClock: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }
}

void _emptyCallback() {}

extension TimeExtension on TimeOfDay {
  /// Return coming [DateTime] at [weekday].
  ///
  /// The [weekday] must be in range `0..6`.
  DateTime toComingDateTimeAt(int weekday) {
    final now = DateTime.now();
    final thisDateTime = DateTime(now.year, now.month, now.day, hour, minute);

    for (int days = 0; days < 7; ++days) {
      final candidate = thisDateTime.add(Duration(days: days));

      if ((candidate.weekday % 7) == weekday) {
        if (candidate.isBefore(now)) {
          return candidate.add(const Duration(days: 7));
        }
        return candidate;
      }
    }
    throw const FormatException("The weekday value must be in range 0..7");
  }
}
