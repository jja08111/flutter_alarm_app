import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_alarm_app/model/alarm.dart';
import 'package:flutter_alarm_app/provider/alarm_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake/fake_alarm.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    const channel = MethodChannel('plugins.flutter.io/path_provider_macos');
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return ".";
    });
  });

  tearDown(() {
    try {
      File('alarms.txt').deleteSync();
    } on FileSystemException {
      assert(true);
    }
  });

  test('getAvailableAlarmId function returns multiples of 7', () {
    final alarmListProvider = AlarmListProvider([]);

    int availableAlarmId = alarmListProvider.getAvailableAlarmId();
    expect(availableAlarmId % 7, 0);

    final newAlarm = Alarm(
      id: availableAlarmId,
      hour: 1,
      minute: 10,
      enabled: true,
    );
    alarmListProvider.add(newAlarm);

    availableAlarmId = alarmListProvider.getAvailableAlarmId();
    expect(availableAlarmId % 7, 0);
  });

  test('getAlarmBy function returns alarm correctly', () {
    final alarmListProvider = AlarmListProvider([fakeAlarm]);

    final alarm = alarmListProvider.getAlarmBy(fakeAlarm.id + DateTime.friday);
    expect(alarm, fakeAlarm);
  });
}
