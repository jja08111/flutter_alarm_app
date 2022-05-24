import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/service/alarm_polling_worker.dart';
import 'package:flutter_alarm_app/provider/alarm_state.dart';
import 'package:flutter_alarm_app/view/alarm_observer.dart';
import 'package:flutter_alarm_app/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final AlarmState alarmState = AlarmState();

  // 앱 진입시 알람 탐색을 시작해야 한다.
  AlarmPollingWorker().createPollingWorker(alarmState);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => alarmState),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Android Alarm Demo',
      theme: ThemeData(useMaterial3: true),
      home: AlarmObserver(child: HomeScreen()),
    );
  }
}
