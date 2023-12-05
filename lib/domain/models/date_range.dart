import 'package:flutter/material.dart' show DateUtils;
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class DateRange {
  final DateTime start;
  final DateTime end;

  DateRange({
    required this.start,
    required this.end,
  });

  /// Returns a date range of current date.
  factory DateRange.now() {
    final currentDate = DateUtils.dateOnly(DateTime.now());
    final weekday = currentDate.weekday % 7;
    final start = DateTime(currentDate.year, currentDate.month, currentDate.day - weekday);
    final end = start.copyWith(day: start.day + 6);
    return DateRange(start: start, end: end);
  }

  factory DateRange.fromDate(DateTime date) {
    final weekday = date.weekday % 7;
    final start = DateTime(date.year, date.month, date.day - weekday);
    final end = start.copyWith(day: start.day + 6);
    return DateRange(start: start, end: end);
  }

  List<DateTime> getDates() {
    final dates = <DateTime>[];
    for (int i = 0; i < 7; i++) {
      dates.add(start.copyWith(day: start.day + i));
    }
    return dates;
  }

  @override
  String toString() {
    if (start.month == end.month) {
      final dates = '${start.day}-${end.day}';
      return '${start.monthName} $dates, ${start.year}';
    }

    return '';
  }
}
