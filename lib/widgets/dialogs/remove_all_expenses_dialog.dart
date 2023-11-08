import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RemoveAllExpensesDialog extends StatefulWidget {
  final void Function() onDelete;

  const RemoveAllExpensesDialog({
    super.key,
    required this.onDelete,
  });

  @override
  State<RemoveAllExpensesDialog> createState() => _RemoveAllExpensesDialogState();
}

class _RemoveAllExpensesDialogState extends State<RemoveAllExpensesDialog> {
  final _deleteController = TextEditingController();

  bool _enableDelete = false;

  @override
  void initState() {
    _deleteController.addListener(() {
      if (_deleteController.text == 'DELETE') {
        setState(() {
          _enableDelete = true;
        });
      } else {
        setState(() {
          _enableDelete = false;
        });
      }
    });
    super.initState();
  }

  void _deleteAllExpenses() {
    widget.onDelete();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: const Icon(Icons.delete_forever_rounded),
      title: const Text('Delete all expenses?'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Deleting all expenses is not an undoable action!'),
            const Text(
              'You will lose all of your expense records and may have to enter it manually'
              ' if you changed your mind after deleting.',
            ),
            const Text('\nIf you are sure that you want to delete all expenses, type "DELETE" below\n'),
            TextField(
              controller: _deleteController,
              decoration: const InputDecoration(
                hintText: 'Type "DELETE"',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _enableDelete ? _deleteAllExpenses : null,
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
