import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

enum _HomeAspect { recent, monthlyExpenses, monthlyAmount, todayAmount }

class HomeProvider extends InheritedModel<_HomeAspect> {
  final List<Expense> recentExpenses;
  final List<Expense> monthlyExpenses;

  const HomeProvider._({
    super.key,
    required this.recentExpenses,
    required this.monthlyExpenses,
    required super.child,
  });

  static HomeProvider _of(BuildContext context, {_HomeAspect? aspect}) {
    final result = InheritedModel.inheritFrom<HomeProvider>(context, aspect: aspect);
    assert(result != null, 'No HomeProvider found in context');
    return result!;
  }

  static UnmodifiableListView<Expense> recentExpensesOf(BuildContext context) {
    final recentExpenses = _of(context, aspect: _HomeAspect.recent).recentExpenses;
    return UnmodifiableListView(recentExpenses);
  }

  static UnmodifiableListView<Expense> monthlyExpensesOf(BuildContext context) {
    final monthlyExpenses = _of(context, aspect: _HomeAspect.monthlyExpenses).monthlyExpenses;
    return UnmodifiableListView(monthlyExpenses);
  }

  static Amount monthlyAmountOf(BuildContext context) {
    final monthlyExpenses = _of(context, aspect: _HomeAspect.monthlyExpenses).monthlyExpenses;
    final amounts = monthlyExpenses.map((e) => e.amount);
    return amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
  }

  @override
  bool updateShouldNotify(covariant HomeProvider oldWidget) {
    return true;
  }

  @override
  bool updateShouldNotifyDependent(covariant HomeProvider oldWidget, Set<Object> dependencies) {
    for (final dependency in dependencies) {
      if (dependency is _HomeAspect) {
        switch (dependency) {
          case _HomeAspect.recent:
            if (recentExpenses.length != oldWidget.recentExpenses.length) {
              return true;
            }
          case _HomeAspect.monthlyExpenses || _HomeAspect.monthlyAmount || _HomeAspect.todayAmount:
            if (monthlyExpenses.length != oldWidget.monthlyExpenses.length) {
              return true;
            }
        }
      }
    }

    return false;
  }
}

class HomePageController extends StatefulWidget {
  final ExpenseRepository expenseRepository;
  final Widget Function(
    Stream<Amount> monthlyAmount,
    Stream<Amount> todayAmount,
    Stream<List<Expense>> recentExpenses,
  ) builder;

  const HomePageController({
    super.key,
    required this.expenseRepository,
    required this.builder,
  });

  @override
  State<HomePageController> createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController> {
  late final Stream<Amount> watchMonthlyAmount;
  late final Stream<Amount> watchTodayAmount;
  late final Stream<List<Expense>> watchRecentExpenses;

  @override
  void initState() {
    watchMonthlyAmount = widget.expenseRepository.watchMonthlyAmount(DateTime.now());
    watchTodayAmount = widget.expenseRepository.watchTodayAmount();
    watchRecentExpenses = widget.expenseRepository.watchRecent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(watchMonthlyAmount, watchTodayAmount, watchRecentExpenses);
  }
}
