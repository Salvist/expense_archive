import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/category_expense.dart';
import 'package:simple_expense_tracker/app/providers/expense_category_provider.dart';
import 'package:simple_expense_tracker/app/providers/expenses_provider.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class CategoryExpenseListView extends StatelessWidget {
  const CategoryExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    final allExpenses = InheritedExpenses.of(context).data;
    final categories = ExpenseCategories.of(context);

    final categoryExpenses = <CategoryExpense>[];

    for (final category in categories) {
      final expenses = allExpenses.where((expense) => expense.category.name == category.name);
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
        ),
        ...categoryExpenses.map((e) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(e.category.icon),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.category.name),
                Text('${e.totalAmount}'),
              ],
            ),
          );
        }),
      ],
    );
  }
}
