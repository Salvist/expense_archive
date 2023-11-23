import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/widgets/fields/cost_field.dart';
import 'package:simple_expense_tracker/widgets/forms/business_form.dart';

class EditBusinessDialog extends StatefulWidget {
  final ExpenseCategory category;
  final Business business;

  const EditBusinessDialog({
    super.key,
    required this.category,
    required this.business,
  });

  @override
  State<EditBusinessDialog> createState() => _EditBusinessDialogState();
}

class _EditBusinessDialogState extends State<EditBusinessDialog> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.business.name;
    _amountController.text = widget.business.costPreset?.withoutCurrency() ?? '';
    super.initState();
  }

  void _applyEdit() async {
    final editedBusiness = widget.business.copyWith(
      name: _nameController.text,
      costPreset: Amount.fromString(_amountController.text),
    );

    Navigator.pop(context, editedBusiness);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit business / individual'),
      content: BusinessForm(
        nameController: _nameController,
        amountController: _amountController,
      ),
      actions: [
        TextButton(
          onPressed: _applyEdit,
          child: const Text('Apply edit'),
        )
      ],
    );
  }
}
