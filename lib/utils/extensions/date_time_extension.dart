import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get monthName => DateFormat('MMMM').format(this);
  String get monthNameShort => DateFormat('MMM').format(this);
  String get weekdayName => DateFormat('EEEE').format(this);
  String get weekdayNameShort => DateFormat('E').format(this);
  String format(String pattern) => DateFormat(pattern).format(this);
}
