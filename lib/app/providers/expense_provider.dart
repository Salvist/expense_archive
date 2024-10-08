import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

class ExpenseProvider extends InheritedWidget {
  final List<Expense> data;
  final void Function(Expense expense) addExpense;
  final void Function() removeAll;
  final void Function(Expense expense) removeExpense;

  const ExpenseProvider._({
    super.key,
    required this.data,
    required this.addExpense,
    required this.removeAll,
    required this.removeExpense,
    required super.child,
  });

  UnmodifiableListView<Expense> get recent {
    final recentExpenses = data.reversed.take(5);
    return UnmodifiableListView(recentExpenses);
  }

  UnmodifiableListView<Expense> getExpensesByMonth(DateTime date) {
    final monthlyExpenses = data.where((expense) => DateUtils.isSameMonth(expense.paidAt, date));
    return UnmodifiableListView(monthlyExpenses);
  }

  Amount getTotalAmountByMonth(DateTime date) {
    final monthlyExpenses = getExpensesByMonth(date);
    final amounts = monthlyExpenses.map((e) => e.amount);
    return amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
  }

  Amount getTotalAmountByDate(DateTime date) {
    final dayExpenses = data.where((expense) => DateUtils.isSameDay(expense.paidAt, date));
    final amounts = dayExpenses.map((e) => e.amount);
    return amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
  }

  static ExpenseProvider of(BuildContext context) {
    final ExpenseProvider? result = context.dependOnInheritedWidgetOfExactType<ExpenseProvider>();
    assert(result != null, 'No InheritedExpenses found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ExpenseProvider oldWidget) {
    return true;
  }
}

class ExpenseNotifier extends StatefulWidget {
  final ExpenseRepository repository;

  final Widget child;
  const ExpenseNotifier({
    super.key,
    required this.repository,
    required this.child,
  });

  @override
  State<ExpenseNotifier> createState() => ExpenseNotifierState();
}

class ExpenseNotifierState extends State<ExpenseNotifier> {
  final expenses = <Expense>[];

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    final e = await widget.repository.getAll();
    expenses.clear();
    setState(() {
      expenses.addAll(e);
    });
  }

  void addExpense(Expense expense) async {
    final addedExpense = await widget.repository.add(expense);

    setState(() {
      expenses.add(addedExpense);
      expenses.sort((a, b) => a.paidAt.compareTo(b.paidAt));
    });
  }

  void removeExpense(Expense expense) {
    widget.repository.remove(expense);
    setState(() {
      expenses.remove(expense);
    });
  }

  void removeAllExpense() {
    widget.repository.removeAll();
    setState(() {
      expenses.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpenseProvider._(
      data: expenses,
      addExpense: addExpense,
      removeAll: removeAllExpense,
      removeExpense: removeExpense,
      child: widget.child,
    );
  }
}
