import 'package:flutter/material.dart';
import 'package:flutter_alarm_app/service/alarm_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Returns DateTime correctly if weekday is same with now', () {
    const timeOfDay = TimeOfDay(hour: 4, minute: 50);
    final now = DateTime.now();

    // pass the monday
    final dateTime = timeOfDay.toComingDateTimeAt(now.weekday % 7);

    expect(dateTime.weekday, now.weekday);
    expect(dateTime.isAfter(DateTime.now()), isTrue);
  });

  test('Returns DateTime correctly if weekday is 1(monday)', () {
    const timeOfDay = TimeOfDay(hour: 4, minute: 50);

    // pass the monday
    final dateTime = timeOfDay.toComingDateTimeAt(1);

    expect(dateTime.weekday, DateTime.monday);
    expect(dateTime.isAfter(DateTime.now()), isTrue);
  });

  test('Throws FormatException if weekday is out range', () {
    const timeOfDay = TimeOfDay(hour: 4, minute: 50);

    expect(() => timeOfDay.toComingDateTimeAt(7), throwsA(isA()));
  });
}
