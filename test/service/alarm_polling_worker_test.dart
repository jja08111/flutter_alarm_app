import 'package:flutter_alarm_app/provider/alarm_state.dart';
import 'package:flutter_alarm_app/service/alarm_flag_manager.dart';
import 'package:flutter_alarm_app/service/alarm_polling_worker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fake/fake_alarm.dart';

void main() {
  test('fires alarm if alarm flag exists', () async {
    SharedPreferences.setMockInitialValues({
      AlarmFlagManager.alarmFlagKey: fakeAlarm.id,
    });

    final worker = AlarmPollingWorker();
    final alarmState = AlarmState();

    await worker.createPollingWorker(alarmState);

    expect(alarmState.isFired, isTrue);
    expect(alarmState.callbackAlarmId, fakeAlarm.id);
  });

  test('does not fire alarm if there is no alarm flag', () async {
    SharedPreferences.setMockInitialValues({});

    final worker = AlarmPollingWorker();
    final alarmState = AlarmState();

    await worker.createPollingWorker(alarmState);

    expect(alarmState.isFired, isFalse);
    expect(alarmState.callbackAlarmId, null);
  });
}
