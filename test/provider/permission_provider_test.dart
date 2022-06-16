import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/provider/permission_provider.dart';
import 'package:flutter_alarm_app/view/permission_request_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows PermissionRequestScreen if not granted', (tester) async {
    SharedPreferences.setMockInitialValues({});

    final preferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => PermissionProvider(preferences),
        child: const PermissionRequestScreen(
          child: Text('Home screen'),
        ),
      ),
    ));

    expect(find.text('Home screen'), findsNothing);
  });

  testWidgets('shows child widget if everything is granted', (tester) async {
    SharedPreferences.setMockInitialValues({
      PermissionProvider.systemAlertWindowGranted: true,
    });

    final preferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => PermissionProvider(preferences),
        child: const PermissionRequestScreen(
          child: Text('Home screen'),
        ),
      ),
    ));

    expect(find.text('Home screen'), findsOneWidget);
  });
}
