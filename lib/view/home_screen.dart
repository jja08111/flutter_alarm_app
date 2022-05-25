import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/model/alarm.dart';
import 'package:flutter_alarm_app/provider/alarm_list_provider.dart';
import 'package:flutter_alarm_app/service/alarm_scheduler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _createAlarm(
    BuildContext context,
    AlarmListProvider alarmListProvider,
  ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 30),
    );
    if (time == null) return;

    final alarm = Alarm(
      id: alarmListProvider.generateAlarmId(),
      timeOfDay: time,
      enabled: true,
    );

    alarmListProvider.add(alarm);
    await AlarmScheduler.scheduleRepeatable(alarm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Consumer<AlarmListProvider>(
                builder: (context, alarmList, child) => ListView.builder(
                  itemCount: alarmList.length,
                  itemBuilder: (context, index) {
                    return _AlarmItem(alarm: alarmList[index]);
                  },
                ),
              ),
            ),
            TextButton(
              child: const Text('알람 생성'),
              onPressed: () {
                _createAlarm(context, context.read<AlarmListProvider>());
              },
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: 탭 가능 하도록 수정, 더 많은 정보 보이도록 수정
class _AlarmItem extends StatelessWidget {
  const _AlarmItem({Key? key, required this.alarm}) : super(key: key);

  final Alarm alarm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [Text(alarm.timeOfDay.toString())],
      ),
    );
  }
}
