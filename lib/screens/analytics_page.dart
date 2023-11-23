import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/providers/expenses_provider.dart';
import 'package:simple_expense_tracker/widgets/category_expense_list_view.dart';
import 'package:simple_expense_tracker/widgets/charts/bar_chart.dart';

List<DateTime> _getWeekDates() {
  final currentDate = DateUtils.dateOnly(DateTime.now());
  final dates = <DateTime>[];
  for (int i = 0; i < 7; i++) {
    final x = i - (currentDate.weekday % 7);
    dates.add(DateTime(currentDate.year, currentDate.month, currentDate.day + x));
  }

  return dates;
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expenseProvider = ExpenseProvider.of(context);
    final weekDates = _getWeekDates();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BarChart(
                title: 'Weekly Expense',
                width: double.infinity,
                dataSource: <ChartData>[
                  ChartData(label: 'Sun', value: expenseProvider.getTotalAmountByDate(weekDates[0]).value),
                  ChartData(label: 'Mon', value: expenseProvider.getTotalAmountByDate(weekDates[1]).value),
                  ChartData(label: 'Tue', value: expenseProvider.getTotalAmountByDate(weekDates[2]).value),
                  ChartData(label: 'Wed', value: expenseProvider.getTotalAmountByDate(weekDates[3]).value),
                  ChartData(label: 'Thu', value: expenseProvider.getTotalAmountByDate(weekDates[4]).value),
                  ChartData(label: 'Fri', value: expenseProvider.getTotalAmountByDate(weekDates[5]).value),
                  ChartData(label: 'Sat', value: expenseProvider.getTotalAmountByDate(weekDates[6]).value),
                ],
                trailing: MenuAnchor(
                  // alignmentOffset: Offset(10, 1),
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {},
                      child: const Text('Weekly'),
                    ),
                    MenuItemButton(
                      child: const Text('Monthly'),
                      onPressed: () {},
                    ),
                  ],
                  builder: (context, controller, child) {
                    return TextButton.icon(
                      onPressed: () {
                        controller.isOpen ? controller.close() : controller.open();
                      },
                      label: const Icon(Icons.arrow_drop_down_rounded),
                      icon: const Text('Weekly'),
                    );
                  },
                ),
              ),
              // const SizedBox(height: 32),
              const CategoryExpenseListView(),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
