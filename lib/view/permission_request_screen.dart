import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/provider/permission_provider.dart';
import 'package:provider/provider.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<PermissionProvider>(
      builder: (context, provider, _) {
        if (provider.isGrantedAll()) {
          return child;
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('알람 작동을 위한 권한을 허용해주세요.'),
                TextButton(
                  onPressed: provider.requestSystemAlertWindow,
                  child: const Text('설정하기'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
