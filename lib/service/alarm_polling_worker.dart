import 'package:flutter/cupertino.dart';
import 'package:flutter_alarm_app/service/alarm_flag_manager.dart';
import 'package:flutter_alarm_app/provider/alarm_state.dart';

class AlarmPollingWorker {
  static final AlarmPollingWorker _instance = AlarmPollingWorker._();

  factory AlarmPollingWorker() {
    return _instance;
  }

  AlarmPollingWorker._();

  bool _running = false;

  /// 알람 플래그 탐색을 시작한다.
  Future<void> createPollingWorker(AlarmState alarmState) async {
    if (_running) return;

    debugPrint('Starts polling worker');
    _running = true;
    final int? callbackAlarmId = await _poller(10);
    _running = false;

    if (callbackAlarmId != null) {
      if (!alarmState.isFired) {
        alarmState.fire(callbackAlarmId);
      }
      await AlarmFlagManager().clear();
    }
  }

  /// 알람 플래그를 찾은 경우 해당 알람의 Id를 반환하고, 플래그가 없는 경우 `null`을 반환한다.
  Future<int?> _poller(int iterations) async {
    int? alarmId;
    int iterator = 0;

    await Future.doWhile(() async {
      alarmId = await AlarmFlagManager().getFiredId();
      if (alarmId != null || iterator++ >= iterations) return false;
      await Future.delayed(const Duration(milliseconds: 25));
      return true;
    });
    return alarmId;
  }
}
