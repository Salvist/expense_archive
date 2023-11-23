import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/providers/expenses_provider.dart';
import 'package:simple_expense_tracker/utils/available_icons.dart';
import 'package:simple_expense_tracker/utils/extensions/currency_extension.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class ExpenseInfoDialog extends StatefulWidget {
  final Expense expense;

  const ExpenseInfoDialog(
    this.expense, {
    super.key,
  });

  @override
  State<ExpenseInfoDialog> createState() => _ExpenseInfoDialogState();
}

class _ExpenseInfoDialogState extends State<ExpenseInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(categoryIcons[widget.expense.category.iconName]),
      title: Text('${widget.expense.name} ${widget.expense.amount}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Category: ${widget.expense.category.name}'),
          Text('Paid on ${widget.expense.paidAt.format('yMMMd')}'),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            ExpenseProvider.of(context).removeExpense(widget.expense);
            Navigator.pop(context);
          },
          child: const Text('Remove'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        )
      ],
    );
  }
}
