import 'package:intl/intl.dart';

final class Amount {
  final double value;
  const Amount(this.value);

  /// Returns null if given string is null or empty.
  static Amount? fromString(String? value) {
    if (value == null || value.isEmpty) return null;
    return Amount(double.parse(value));
  }

  static const zero = Amount(0.0);

  String withoutCurrency() => value.toStringAsFixed(2);

  @override
  String toString() => NumberFormat.simpleCurrency(decimalDigits: 2).format(value);

  Amount operator +(Amount other) => Amount(value + other.value);
}
