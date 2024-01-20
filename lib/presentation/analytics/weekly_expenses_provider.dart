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

  static WeeklyExpensesControllerState of(BuildContext context) {
    return context.findAncestorStateOfType<WeeklyExpensesControllerState>()!;
  }

  @override
  State<WeeklyExpensesController> createState() => WeeklyExpensesControllerState();
}

class WeeklyExpensesControllerState extends State<WeeklyExpensesController> {
  var _weeklyExpenses = <Expense>[];
  DateTime _currentDate = DateTime.now();
  DateRange get _weekDates => DateRange.fromDate(_currentDate);
  late DateTime startDate;
  late DateTime endDate;

  static const _oneWeek = Duration(days: 7);

  bool isLoading = false;

  @override
  void initState() {
    init();

    super.initState();
  }

  void init() async {
    final dates = await widget.expenseRepository.getStartAndEndDates();
    startDate = dates.start;
    endDate = dates.end;
    widget.expenseRepository.getByWeek(_currentDate).then((expenses) {
      setState(() {
        _weeklyExpenses = expenses;
      });
    });
  }

  void nextWeek() async {
    _currentDate = _currentDate.add(_oneWeek);
    final expenses = await widget.expenseRepository.getByWeek(_currentDate);
    setState(() {
      _weeklyExpenses = expenses;
    });
  }

  void prevWeek() async {
    _currentDate = _currentDate.add(const Duration(days: -7));
    final expenses = await widget.expenseRepository.getByWeek(_currentDate);
    setState(() {
      _weeklyExpenses = expenses;
    });
  }

  bool get hasNextWeek => _weekDates.end.isBefore(endDate);

  @override
  Widget build(BuildContext context) {
    return widget.builder(this);
  }
}
