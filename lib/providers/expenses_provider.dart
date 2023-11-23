import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/models/total_expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';
import 'package:simple_expense_tracker/utils/extensions/currency_extension.dart';

class InheritedExpenses extends InheritedWidget {
  final List<Expense> data;

  String get today {
    final currentDate = DateTime.now();
    final expenses = data.where((expense) => DateUtils.isSameDay(expense.paidAt, currentDate));
    final totalExpense = expenses.fold(Amount.zero, (previousValue, expense) => previousValue + expense.amount);
    return '$totalExpense';
  }

  String get monthly {
    final currentDate = DateTime.now();
    final monthlyExpenses = data.where((expense) => DateUtils.isSameMonth(expense.paidAt, currentDate));
    final expense =
        monthlyExpenses.fold<Amount>(Amount.zero, (previousValue, element) => previousValue + element.amount);
    return '$expense';
  }

  UnmodifiableListView<Expense> get recent {
    final recentExpenses = data.reversed.take(5);
    return UnmodifiableListView(recentExpenses);
  }

  const InheritedExpenses({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);

  static InheritedExpenses of(BuildContext context) {
    final InheritedExpenses? result = context.dependOnInheritedWidgetOfExactType<InheritedExpenses>();
    assert(result != null, 'No InheritedExpenses found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedExpenses oldWidget) {
    return true;
  }
}

class ExpenseProvider extends StatefulWidget {
  final ExpenseRepository repository;

  final Widget child;
  const ExpenseProvider({
    super.key,
    required this.repository,
    required this.child,
  });

  static ExpenseProviderState of(BuildContext context) {
    return context.findAncestorStateOfType<ExpenseProviderState>()!;
  }

  @override
  State<ExpenseProvider> createState() => ExpenseProviderState();
}

class ExpenseProviderState extends State<ExpenseProvider> {
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
    });
  }

  Amount getTotalAmountByDate(DateTime date) {
    final dayExpenses = expenses.where((expense) => DateUtils.isSameDay(expense.paidAt, date));
    final amounts = dayExpenses.map((e) => e.amount);
    return amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
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
    return InheritedExpenses(
      data: expenses,
      child: widget.child,
    );
  }
}
