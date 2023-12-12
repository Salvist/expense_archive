import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/presentation/analytics/monthly_expenses_provider.dart';
import 'package:simple_expense_tracker/utils/extensions/expense_list_extension.dart';
import 'package:simple_expense_tracker/widgets/dropdown_chip.dart';

class MonthlyExpensesView extends StatelessWidget {
  const MonthlyExpensesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final monthlyProvider = MonthlyExpensesProvider.of(context);
    final monthlyAmount = monthlyProvider.expenses.getTotalAmount();
    // final expenses = ExpenseProvider.of(context).getTotalAmount();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Monthly Expenses', style: TextStyle(fontSize: 16)),
        Row(
          children: [
            DropdownChip<String>(
              value: 'December',
              otherValues: [],
              onChanged: (newValue) {},
            ),
            const SizedBox(width: 4),
            DropdownChip<String>(
              value: '2023',
              otherValues: [],
              onChanged: (newValue) {},
            ),
          ],
        ),
        ...monthlyProvider.categoryExpenses.map((e) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(e.category.icon, color: Theme.of(context).colorScheme.primary),
            ),
            title: Text(e.category.name),
            subtitle: Text(e.totalAmount.inPercentOf(monthlyAmount)),
            trailing: Text('${e.totalAmount}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          );
        }),
      ],
    );
  }
}
