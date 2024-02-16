import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/date_range.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';
import 'package:simple_expense_tracker/utils/extensions/expense_list_extension.dart';

class MonthlyExpensesController extends StatefulWidget {
  final ExpenseRepository expenseRepository;
  final ExpenseCategoryRepository categoryRepository;
  final Widget Function(MonthlyExpensesControllerState controller) builder;

  const MonthlyExpensesController({
    super.key,
    required this.expenseRepository,
    required this.categoryRepository,
    required this.builder,
  });

  @override
  State<MonthlyExpensesController> createState() => MonthlyExpensesControllerState();
}

class MonthlyExpensesControllerState extends State<MonthlyExpensesController> {
  var _monthlyExpenses = <Expense>[];

  DateTime _currentDate = DateTime.now();
  DateTime get selectedMonthDate => _currentDate;

  DateTime? _startDate;
  DateTime get startDate => _startDate ?? DateTime.now();
  DateTime get endDate => DateTime.now();

  final _months = <DateTime>[];
  UnmodifiableListView<DateTime> get months => UnmodifiableListView(_months.isEmpty ? [DateTime.now()] : _months);

  UnmodifiableListView<Expense> get monthlyExpenses => UnmodifiableListView(_monthlyExpenses);
  DateRange? dateRange;

  final _expensesByCategory = <ExpenseCategory, List<Expense>>{};
  UnmodifiableMapView<ExpenseCategory, List<Expense>> get categoryExpenses => UnmodifiableMapView(_expensesByCategory);

  UnmodifiableMapView<ExpenseCategory, Amount> get totalAmountByCategory {
    final map = _expensesByCategory.map((key, value) => MapEntry(key, value.getTotalAmount()));
    final x = SplayTreeMap<ExpenseCategory, Amount>.from(map, (key1, key2) => map[key2]!.compareTo(map[key1]!));
    return UnmodifiableMapView(x);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void initState() {
    loadMonthlyExpenses();
    widget.expenseRepository.getStartDate().then((value) {
      setState(() {
        _months.clear();
        _startDate = value;
        final currentDate = DateTime.now();
        final monthDelta = DateUtils.monthDelta(startDate, currentDate);
        for (int i = 0; i <= monthDelta; i++) {
          _months.add(DateTime(currentDate.year, currentDate.month - i));
        }
      });
    });
    super.initState();
  }

  void loadMonthlyExpenses() async {
    try {
      setState(() {
        _isLoading = true;
      });
      _expensesByCategory.clear();
      _monthlyExpenses = await widget.expenseRepository.getByMonth(_currentDate);

      for (final expense in _monthlyExpenses) {
        if (_expensesByCategory[expense.category] != null) {
          _expensesByCategory[expense.category]!.add(expense);
        } else {
          _expensesByCategory[expense.category] = [expense];
        }
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void changeMonthDate(DateTime date) {
    setState(() {
      _currentDate = date;
    });
    loadMonthlyExpenses();
  }

  @override
  Widget build(BuildContext context) => widget.builder(this);
}
