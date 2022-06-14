import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/provider/permission_provider.dart';
import 'package:flutter_alarm_app/view/home_screen.dart';
import 'package:provider/provider.dart';

class PermissionRequestScreen extends StatefulWidget {
  const PermissionRequestScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<PermissionRequestScreen> createState() =>
      _PermissionRequestScreenState();
}

class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
  void _requestPermission(BuildContext context) async {
    final provider = context.read<PermissionProvider>();
    final granted = await provider.requestSystemAlertWindow();

    if (granted && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PermissionProvider>(
      builder: (context, provider, _) {
        if (provider.isGrantedAll()) {
          return widget.child;
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('알람 작동을 위한 권한을 허용해주세요.'),
                TextButton(
                  onPressed: () {
                    _requestPermission(context);
                  },
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
