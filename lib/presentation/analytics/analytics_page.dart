import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/expense_provider.dart';
import 'package:simple_expense_tracker/domain/models/date_range.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';
import 'package:simple_expense_tracker/widgets/category_expense_list_view.dart';
import 'package:simple_expense_tracker/widgets/charts/bar_chart.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expenseProvider = ExpenseProvider.of(context);
    final weekDates = DateRange.now();

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
                // subtitle: weekDates.toString(),
                width: double.infinity,
                dataSource: <ChartData>[
                  for (final date in weekDates.getDates())
                    ChartData(label: date.weekdayNameShort, value: expenseProvider.getTotalAmountByDate(date).value),
                ],
                // trailing: MenuAnchor(
                //   // alignmentOffset: Offset(10, 1),
                //   menuChildren: [
                //     MenuItemButton(
                //       onPressed: () {},
                //       child: const Text('Weekly'),
                //     ),
                //     MenuItemButton(
                //       child: const Text('Monthly'),
                //       onPressed: () {},
                //     ),
                //   ],
                //   builder: (context, controller, child) {
                //     return TextButton.icon(
                //       onPressed: () {
                //         controller.isOpen ? controller.close() : controller.open();
                //       },
                //       label: const Icon(Icons.arrow_drop_down_rounded),
                //       icon: const Text('Weekly'),
                //     );
                //   },
                // ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.navigate_before_rounded),
                  ),
                  const Spacer(),
                  Text(weekDates.toString()),
                  const Spacer(),

                  // Column(
                  //   children: [
                  //     Text('Weekly Expense', style: TextStyle(fontSize: 16)),
                  //   ],
                  // ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.navigate_next_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const CategoryExpenseListView(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
