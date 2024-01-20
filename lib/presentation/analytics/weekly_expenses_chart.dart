import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/expense_provider.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/date_range.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/presentation/analytics/weekly_expenses_provider.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';
import 'package:simple_expense_tracker/widgets/charts/bar_chart.dart';
import 'package:simple_expense_tracker/utils/extensions/expense_list_extension.dart';

class WeeklyExpensesChartView extends StatelessWidget {
  final DateRange weekDates;
  final List<Expense> weeklyExpenses;
  final State<WeeklyExpensesController> controller;

  const WeeklyExpensesChartView({
    super.key,
    required this.weekDates,
    required this.weeklyExpenses,
    required this.controller,
  });

  Amount getTotalAmountByDate(DateTime date) {
    final dayExpenses = weeklyExpenses.where((expense) => DateUtils.isSameDay(expense.paidAt, date));
    final amounts = dayExpenses.map((e) => e.amount);
    return amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    // final expenseProvider = ExpenseProvider.of(context);
    // final weeklyExpenses = WeeklyExpensesProvider.of(context);
    // final weekDates = weeklyExpenses.weekDates;

    // final weekDates = DateRange.fromDate(_date);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Weekly Expenses', style: TextStyle(fontSize: 16)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 12)),
                  Text(
                    '${weeklyExpenses.getTotalAmount()}',
                    // 'ASDASDASD',
                    style: const TextStyle(fontWeight: FontWeight.bold, height: 1),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          BarChart(
            contentPadding: EdgeInsets.zero,
            width: double.infinity,
            height: 160,
            dataSource: <ChartData>[
              for (final date in weekDates.getDates())
                ChartData(label: date.weekdayNameShort, value: getTotalAmountByDate(date).value)
              // for (final date in weekDates.getDates())
              //   ChartData(label: date.weekdayNameShort, value: expenseProvider.getTotalAmountByDate(date).value),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  WeeklyExpensesController.of(context).prevWeek();
                },
                icon: const Icon(Icons.navigate_before_rounded),
              ),
              const Spacer(),
              Text(weekDates.toString()),
              const Spacer(),
              IconButton(
                onPressed: () {
                  WeeklyExpensesController.of(context).nextWeek();
                },
                icon: const Icon(Icons.navigate_next_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
