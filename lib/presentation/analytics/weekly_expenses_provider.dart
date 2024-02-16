import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/date_range.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

class WeeklyExpensesController extends StatefulWidget {
  final ExpenseRepository expenseRepository;
  final Widget Function(WeeklyExpensesControllerState controller) builder;

  const WeeklyExpensesController({
    super.key,
    required this.expenseRepository,
    required this.builder,
  });

  @override
  State<WeeklyExpensesController> createState() => WeeklyExpensesControllerState();
}

class WeeklyExpensesControllerState extends State<WeeklyExpensesController> {
  var _weeklyExpenses = <Expense>[];
  UnmodifiableListView<Expense> get weeklyExpenses => UnmodifiableListView(_weeklyExpenses);

  DateTime _currentDate = DateTime.now();
  DateRange get weekDates => DateRange.getWeek(_currentDate);

  static const _oneWeek = Duration(days: 7);

  bool isLoading = false;

  @override
  void initState() {
    loadWeeklyExpenses(_currentDate);
    super.initState();
  }

  void loadWeeklyExpenses(DateTime date) async {
    try {
      setState(() {
        isLoading = true;
      });
      _weeklyExpenses = await widget.expenseRepository.getByWeek(date);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void nextWeek() {
    _currentDate = _currentDate.add(_oneWeek);
    loadWeeklyExpenses(_currentDate);
  }

  void prevWeek() {
    _currentDate = _currentDate.add(const Duration(days: -7));
    loadWeeklyExpenses(_currentDate);
  }

  // bool get hasNextWeek => weekDates.end.isBefore(endDate);

  @override
  Widget build(BuildContext context) {
    return widget.builder(this);
  }
}
