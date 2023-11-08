import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get monthName => DateFormat('MMMM').format(this);
  String format(String pattern) => DateFormat(pattern).format(this);
}
