import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/utils/extensions/currency_extension.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final void Function()? onTap;
  const ExpenseTile({
    super.key,
    required this.expense,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      tileColor: colorScheme.secondaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      leading: Icon(expense.category.icon),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(expense.name),
          // Text('\$${expense.cost}'),
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
  }
}
