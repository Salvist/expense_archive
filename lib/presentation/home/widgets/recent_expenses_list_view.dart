import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/presentation/home/all_expense_page.dart';
import 'package:simple_expense_tracker/widgets/dialogs/expense_info_dialog.dart';
import 'package:simple_expense_tracker/widgets/expense_tile.dart';

class RecentExpensesListView extends StatelessWidget {
  final bool isLoading;
  final List<Expense> recentExpenses;

  const RecentExpensesListView({
    super.key,
    required this.isLoading,
    required this.recentExpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Recent Expenses'),
          subtitle: const Text('Showing 5 recent expenses'),
          trailing: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllExpensePage()));
            },
            child: const Text('View all'),
          ),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          itemCount: recentExpenses.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final expense = recentExpenses[index];
            return ExpenseTile(
              expense: expense,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ExpenseInfoDialog(expense),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
