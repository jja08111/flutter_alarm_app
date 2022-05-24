import 'package:flutter/foundation.dart';

@immutable
class Alarm {
  final int id;
  final DateTime time;

  const Alarm({required this.id, required this.time});
}
