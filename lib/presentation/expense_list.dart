import 'dart:collection';

import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';

class ExpenseList extends ListBase<Expense> {
  final List<Expense> _data;
  const ExpenseList([this._data = const <Expense>[]]);

  Iterable<Amount> get _amounts => _data.map((e) => e.amount);
  Amount get totalAmount => _amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);

  @override
  int get length => _data.length;
  @override
  set length(int newLength) {
    _data.length = newLength;
  }

  @override
  Expense operator [](int index) => _data[index];

  @override
  void operator []=(int index, Expense value) {
    _data[index] = value;
  }
}
