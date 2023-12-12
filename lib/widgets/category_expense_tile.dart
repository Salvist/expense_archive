import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/category_expense.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';

class CategoryExpenseTile extends StatelessWidget {
  final ExpenseCategory category;
  final Iterable<Expense> expenses;

  const CategoryExpenseTile({
    super.key,
    required this.category,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Icon(category.icon),
        ),
        Column(
          children: [
            Text(category.name),
            // Text()
          ],
        )
      ],
    );
  }
}
