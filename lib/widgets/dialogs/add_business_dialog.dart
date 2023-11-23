import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/widgets/forms/business_form.dart';

class AddBusinessDialog extends StatefulWidget {
  final ExpenseCategory category;

  const AddBusinessDialog({
    super.key,
    required this.category,
  });

  @override
  State<AddBusinessDialog> createState() => _AddBusinessDialogState();
}

class _AddBusinessDialogState extends State<AddBusinessDialog> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  void _applyEdit() async {
    final business = Business(
      name: _nameController.text,
      categoryName: widget.category.name,
      costPreset: Amount.fromString(_amountController.text),
    );
    Navigator.pop(context, business);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Add business / individual'),
      icon: Icon(widget.category.icon),
      content: BusinessForm(
        nameController: _nameController,
        amountController: _amountController,
      ),
      actions: [
        TextButton(
          onPressed: _applyEdit,
          child: Text('Add to ${widget.category.name}'),
        )
      ],
    );
  }
}
