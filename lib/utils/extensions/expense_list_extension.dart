import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';

extension ExpenseListExtension on Iterable<Expense> {
  Iterable<Amount> get _amounts => map((e) => e.amount);

  Amount getTotalAmount() => _amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
  Amount getTotalAmountByDate(DateTime date) {
    final dayExpenses = where((expense) => DateUtils.isSameDay(expense.paidAt, date));
    return dayExpenses.getTotalAmount();
  }
}
