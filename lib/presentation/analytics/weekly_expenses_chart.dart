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
  final WeeklyExpensesControllerState controller;

  const WeeklyExpensesChartView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final weekDates = controller.weekDates;
    final weeklyExpenses = controller.weeklyExpenses;

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
                ChartData(
                  label: date.weekdayNameShort,
                  value: weeklyExpenses.getTotalAmountByDate(date).value,
                )
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  controller.prevWeek();
                },
                icon: const Icon(Icons.navigate_before_rounded),
              ),
              const Spacer(),
              Text(weekDates.toString()),
              const Spacer(),
              IconButton(
                onPressed: () {
                  controller.nextWeek();
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
