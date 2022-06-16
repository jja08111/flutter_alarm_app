import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/provider/alarm_list_provider.dart';
import 'package:flutter_alarm_app/provider/alarm_state.dart';
import 'package:flutter_alarm_app/view/alarm_observer.dart';
import 'package:flutter_alarm_app/view/alarm_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../fake/fake_alarm.dart';

void main() {
  testWidgets('shows AlarmScreen if alarm is fired', (tester) async {
    final AlarmState alarmState = AlarmState();
    final AlarmListProvider alarmList = AlarmListProvider([fakeAlarm]);

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<AlarmState>(create: (_) => alarmState),
        ChangeNotifierProvider<AlarmListProvider>(create: (_) => alarmList),
      ],
      child: const MaterialApp(
        home: AlarmObserver(
          child: Text('Home screen'),
        ),
      ),
    ));

    expect(find.byType(AlarmScreen), findsNothing);

    alarmState.fire(fakeAlarm.id);
    await tester.pump();

    expect(find.byType(AlarmScreen), findsOneWidget);
  });
}
