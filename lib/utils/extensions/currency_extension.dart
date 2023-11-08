import 'package:intl/intl.dart';

extension CurrencyExtension on double {
  String toCurrency() => NumberFormat.simpleCurrency(decimalDigits: 2).format(this);
}
