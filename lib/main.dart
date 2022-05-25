import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/provider/alarm_list_provider.dart';
import 'package:flutter_alarm_app/service/alarm_polling_worker.dart';
import 'package:flutter_alarm_app/provider/alarm_state.dart';
import 'package:flutter_alarm_app/view/alarm_observer.dart';
import 'package:flutter_alarm_app/view/home_screen.dart';
import 'package:flutter_alarm_app/view/permission_request_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  final AlarmState alarmState = AlarmState();

  // 앱 진입시 알람 탐색을 시작해야 한다.
  AlarmPollingWorker().createPollingWorker(alarmState);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => alarmState),
      ChangeNotifierProvider(create: (context) => AlarmListProvider()),
    ],
    child: MyApp(preferences: await SharedPreferences.getInstance()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.preferences}) : super(key: key);

  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Android Alarm Demo',
      theme: ThemeData(useMaterial3: true),
      home: PermissionRequestScreen(
        preferences: preferences,
        child: const AlarmObserver(child: HomeScreen()),
      ),
    );
  }
}
