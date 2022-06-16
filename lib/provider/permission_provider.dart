import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionProvider extends ChangeNotifier {
  PermissionProvider(this._preferences);

  @visibleForTesting
  static const String systemAlertWindowGranted = "systemAlertWindowGranted";

  final SharedPreferences _preferences;

  bool isGrantedAll() {
    return _preferences.getBool(systemAlertWindowGranted) ?? false;
  }

  Future<bool> requestSystemAlertWindow() async {
    if (await Permission.systemAlertWindow.status != PermissionStatus.granted) {
      await Permission.systemAlertWindow.request();
    }

    if (await Permission.systemAlertWindow.status == PermissionStatus.granted) {
      await _preferences.setBool(systemAlertWindowGranted, true);
      notifyListeners();
      return true;
    }
    return false;
  }
}
