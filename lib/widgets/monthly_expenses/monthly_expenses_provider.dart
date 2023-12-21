import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/category_expense.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

class MonthlyExpensesProvider extends InheritedWidget {
  final List<Expense> expenses;
  final List<CategoryExpense> categoryExpenses;
  final DateTime selectedDate;
  final MonthlyExpensesControllerState controller;

  const MonthlyExpensesProvider._({
    required this.controller,
    required this.expenses,
    required this.selectedDate,
    required this.categoryExpenses,
    required super.child,
  });

  static MonthlyExpensesProvider of(BuildContext context) {
    final MonthlyExpensesProvider? result = context.dependOnInheritedWidgetOfExactType<MonthlyExpensesProvider>();
    assert(result != null, 'No MonthlyExpensesProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MonthlyExpensesProvider old) {
    return true;
  }
}

class MonthlyExpensesController extends StatefulWidget {
  final ExpenseRepository expenseRepository;
  final ExpenseCategoryRepository categoryRepository;
  final Widget child;

  const MonthlyExpensesController({
    super.key,
    required this.expenseRepository,
    required this.categoryRepository,
    required this.child,
  });

  @override
  State<MonthlyExpensesController> createState() => MonthlyExpensesControllerState();
}

class MonthlyExpensesControllerState extends State<MonthlyExpensesController> {
  var _monthlyExpenses = <Expense>[];
  var _categoryExpenses = <CategoryExpense>[];
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final expenses = await widget.expenseRepository.getByMonth(_currentDate);
    _monthlyExpenses = expenses;
    final categories = await widget.categoryRepository.getAll();
    final categoryExpenses = <CategoryExpense>[];

    for (final category in categories) {
      final expenses = _monthlyExpenses.where((expense) => expense.category.name == category.name);
      if (expenses.isNotEmpty) {
        categoryExpenses.add(CategoryExpense(category: category, expenses: expenses.toList()));
      }
    }
    categoryExpenses.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));

    setState(() {
      _categoryExpenses = categoryExpenses;
    });
  }

  void changeMonth(int month) {
    setState(() {
      _currentDate = _currentDate.copyWith(month: month);
    });
  }

  void changeYear(int year) {
    setState(() {
      _currentDate = _currentDate.copyWith(year: year);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MonthlyExpensesProvider._(
      controller: this,
      selectedDate: _currentDate,
      expenses: _monthlyExpenses,
      categoryExpenses: _categoryExpenses,
      child: widget.child,
    );
  }
}
