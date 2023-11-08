import 'package:flutter/material.dart';
import 'package:money_archive/domain/models/expense.dart';
import 'package:money_archive/providers/expenses_provider.dart';
import 'package:money_archive/utils/code_point_to_icon.dart';
import 'package:money_archive/utils/extensions/currency_extension.dart';
import 'package:money_archive/utils/extensions/date_time_extension.dart';

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
      icon: Icon(getIconData(widget.expense.category.iconCodePoint)),
      title: Text('${widget.expense.name} ${widget.expense.cost.toCurrency()}'),
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
