import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/date_range.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

class WeeklyExpensesProvider extends InheritedWidget {
  final DateRange weekDates;
  final List<Expense> data;

  const WeeklyExpensesProvider({
    super.key,
    required this.weekDates,
    required this.data,
    required super.child,
  });

  Amount getTotalAmountByDate(DateTime date) {
    final dayExpenses = data.where((expense) => DateUtils.isSameDay(expense.paidAt, date));
    final amounts = dayExpenses.map((e) => e.amount);
    return amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
  }

  static WeeklyExpensesProvider of(BuildContext context) {
    final WeeklyExpensesProvider? result = context.dependOnInheritedWidgetOfExactType<WeeklyExpensesProvider>();
    assert(result != null, 'No WeeklyExpensesProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(WeeklyExpensesProvider old) {
    return true;
  }
}

class WeeklyExpensesController extends StatefulWidget {
  final ExpenseRepository expenseRepository;
  final Widget child;

  const WeeklyExpensesController({
    super.key,
    required this.expenseRepository,
    required this.child,
  });

  static WeeklyExpensesControllerState of(BuildContext context) {
    return context.findAncestorStateOfType<WeeklyExpensesControllerState>()!;
  }

  @override
  State<WeeklyExpensesController> createState() => WeeklyExpensesControllerState();
}

class WeeklyExpensesControllerState extends State<WeeklyExpensesController> {
  var _expenses = <Expense>[];
  DateTime _currentDate = DateTime.now();
  DateRange get _weekDates => DateRange.fromDate(_currentDate);
  late DateTime startDate;
  late DateTime endDate;

  static const _oneWeek = Duration(days: 7);

  bool isLoading = false;

  @override
  void initState() {
    // widget.expenseRepository.getStartAndEndDates().then((dates) {
    //   setState(() {
    //     startDate = dates.start;
    //     endDate = dates.end;
    //   });
    // });
    init();

    super.initState();
  }

  void init() async {
    final dates = await widget.expenseRepository.getStartAndEndDates();
    startDate = dates.start;
    endDate = dates.end;
    widget.expenseRepository.getByWeek(_currentDate).then((expenses) {
      setState(() {
        _expenses = expenses;
      });
    });
  }

  void nextWeek() async {
    _currentDate = _currentDate.add(_oneWeek);
    final expenses = await widget.expenseRepository.getByWeek(_currentDate);
    setState(() {
      _expenses = expenses;
    });
  }

  void prevWeek() async {
    _currentDate = _currentDate.add(const Duration(days: -7));
    final expenses = await widget.expenseRepository.getByWeek(_currentDate);
    setState(() {
      _expenses = expenses;
    });
  }

  bool get hasNextWeek => _weekDates.end.isBefore(endDate);

  @override
  Widget build(BuildContext context) {
    return WeeklyExpensesProvider(
      weekDates: _weekDates,
      data: _expenses,
      child: widget.child,
    );
  }
}
