import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';
import 'package:simple_expense_tracker/utils/extensions/expense_list_extension.dart';
import 'package:simple_expense_tracker/widgets/monthly_expenses/monthly_expenses_provider.dart';

class MonthlyExpensesView extends StatelessWidget {
  final MonthlyExpensesControllerState controller;
  const MonthlyExpensesView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const CircularProgressIndicator();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Monthly Expenses', style: TextStyle(fontSize: 16)),
        MonthSelector(
          selectedMonth: controller.selectedMonthDate,
          options: controller.months,
          onChanged: controller.changeMonthDate,
        ),
        ...controller.totalAmountByCategory.entries.map((e) {
          final category = e.key;
          final amount = e.value;
          return ListTile(
            leading: CircleAvatar(
              child: Icon(category.icon, color: Theme.of(context).colorScheme.primary),
            ),
            title: Text(category.name),
            subtitle: Text(amount.inPercentOf(controller.monthlyExpenses.getTotalAmount())),
            trailing: Text(
              '$amount',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }),
      ],
    );
  }
}

class MonthSelector extends StatelessWidget {
  final DateTime selectedMonth;
  final List<DateTime> options;
  final void Function(DateTime date) onChanged;

  const MonthSelector({
    super.key,
    required this.selectedMonth,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kMinInteractiveDimension,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final option = options[index];
          return FilterChip(
            label: Text(option.format('yMMM')),
            selected: DateUtils.isSameMonth(option, selectedMonth),
            onSelected: (_) => onChanged(option),
          );
        },
      ),
    );
  }
}
