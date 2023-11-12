import 'package:flutter/material.dart';
import 'package:money_archive/providers/expenses_provider.dart';
import 'package:money_archive/utils/extensions/date_time_extension.dart';
import 'package:money_archive/widgets/dialogs/expense_info_dialog.dart';

class AllExpensePage extends StatelessWidget {
  const AllExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = InheritedExpenses.of(context).data;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Expense'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];

          return ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ExpenseInfoDialog(expense),
              );
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(expense.name),
                Text('${expense.amount}'),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(expense.category.name),
                Text(expense.paidAt.format('MMMd')),
              ],
            ),
          );
        },
      ),
    );
  }
}
