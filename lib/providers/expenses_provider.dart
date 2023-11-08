import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:money_archive/domain/models/expense.dart';
import 'package:money_archive/domain/repositories/expense_repository.dart';
import 'package:money_archive/utils/extensions/currency_extension.dart';

class InheritedExpenses extends InheritedWidget {
  final List<Expense> data;

  String get today {
    final currentDate = DateTime.now();
    final expenses = data.where((expense) => DateUtils.isSameDay(expense.paidAt, currentDate));
    final totalExpense = expenses.fold(0.0, (previousValue, expense) => previousValue + expense.cost);
    return totalExpense.toCurrency();
  }

  String get monthly {
    final currentDate = DateTime.now();
    final monthlyExpenses = data.where((expense) => DateUtils.isSameMonth(expense.paidAt, currentDate));
    final expense = monthlyExpenses.fold<double>(0.0, (previousValue, element) => previousValue + element.cost);
    return expense.toCurrency();
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
