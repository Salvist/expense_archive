import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/expense_category_provider.dart';
import 'package:simple_expense_tracker/app/providers/expense_provider.dart';
import 'package:simple_expense_tracker/domain/models/category_expense.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class CategoryExpenseListView extends StatelessWidget {
  const CategoryExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final monthlyExpenses = ExpenseProvider.of(context).getExpensesByMonth(currentDate);
    final categories = CategoryProvider.of(context).data;
    final monthlyAmount = ExpenseProvider.of(context).getTotalAmountByMonth(currentDate);

    final categoryExpenses = <CategoryExpense>[];

    for (final category in categories) {
      final expenses = monthlyExpenses.where((expense) => expense.category.name == category.name);
      if (expenses.isNotEmpty) {
        categoryExpenses.add(CategoryExpense(category: category, expenses: expenses.toList()));
      }
    }
    categoryExpenses.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          title: const Text('Expenses by Category'),
          subtitle: Text(DateTime.now().format('yMMMM')),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Total', style: TextStyle(fontSize: 13)),
              Text(
                '$monthlyAmount',
                style: const TextStyle(fontSize: 17, color: Colors.black),
              ),
            ],
          ),
        ),
        ...categoryExpenses.map((e) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(e.category.icon, color: Theme.of(context).colorScheme.primary),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.category.name),
                Text('${e.totalAmount}'),
              ],
            ),
            subtitle: Text(e.totalAmount.inPercentOf(monthlyAmount)),
            // trailing: Text('${e.totalAmount}'),
          );
        }),
      ],
    );
  }
}
