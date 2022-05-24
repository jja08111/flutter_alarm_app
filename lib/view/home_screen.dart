import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _handleCreateButton(BuildContext context) async {
    final time = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 2),
      lastDate: DateTime(2022, 1, 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('알람 만들기'),
          onPressed: () {
            _handleCreateButton(context);
          },
        ),
      ),
    );
  }
}
