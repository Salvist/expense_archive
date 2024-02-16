import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/repository_provider.dart';

class RemoveCategoryDialog extends StatefulWidget {
  final ExpenseCategory category;
  final void Function(ExpenseCategory category) onRemove;

  const RemoveCategoryDialog({
    super.key,
    required this.category,
    required this.onRemove,
  });

  @override
  State<RemoveCategoryDialog> createState() => _RemoveCategoryDialogState();
}

class _RemoveCategoryDialogState extends State<RemoveCategoryDialog> {
  bool _dontAskAgain = false;

  void _removeCategory() {
    final sharedPrefsRepo = RepositoryProvider.sharedPrefsOf(context);
    sharedPrefsRepo.setAskOnRemoveCategory(!_dontAskAgain);
    widget.onRemove(widget.category);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Remove Category ${widget.category.name}?'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Removing a category will NOT remove all expenses that is associated with this category.'),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _dontAskAgain,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _dontAskAgain = value;
                    });
                  },
                ),
                const Text('Don\'t ask again'),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: _removeCategory,
          child: const Text('Remove'),
        ),
      ],
    );
  }
}
