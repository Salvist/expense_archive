import 'package:flutter/material.dart' show DateUtils;
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class DateRange {
  final DateTime start;
  final DateTime end;

  int get monthDifference => start.difference(end).inDays ~/ 365 ~/ 30 + 1;

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

  /// Returns a [DateRange] from Sunday to Saturday from given [date]
  factory DateRange.getWeek(DateTime date) {
    final weekday = date.weekday % 7;
    final start = DateTime(date.year, date.month, date.day - weekday);
    final end = start.copyWith(day: start.day + 7, millisecond: -1);
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
    if (start.year == end.year) {
      final startDate = '${start.monthNameShort} ${start.day}';
      final endDate = '${end.monthNameShort} ${end.day}';
      return '$startDate - $endDate, ${end.year}';
    }
    return '${start.monthNameShort} ${start.day}, ${start.year} - ${end.monthNameShort} ${end.day}, ${end.year}';
  }
}
