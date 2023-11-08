import 'package:flutter/material.dart';

import 'package:money_archive/providers/expense_category_provider.dart';
import 'package:money_archive/utils/available_icons.dart';

class AddExpenseCategoryPage extends StatefulWidget {
  const AddExpenseCategoryPage({super.key});

  @override
  State<AddExpenseCategoryPage> createState() => _AddExpenseCategoryPageState();
}

class _AddExpenseCategoryPageState extends State<AddExpenseCategoryPage> {
  final _nameController = TextEditingController();
  String? _nameErrorMessage;

  IconData? iconData;

  Icon? _icon;
  final availableIcons = AvailableIcons.icons;

  void _addCategory() async {
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameErrorMessage = 'Write category name';
      });
      return;
    }

    final addedCategory = await ExpenseCategoryProvider.of(context).addCategory(
      name: _nameController.text,
      iconData: _icon?.icon?.codePoint,
    );
    if (!mounted) return;
    Navigator.pop(context, addedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add a new category'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  child: _icon,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      label: const Text('Category name'),
                      helperText: '',
                      errorText: _nameErrorMessage,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: availableIcons.length,
              itemBuilder: (context, index) {
                final icon = availableIcons[index];
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _icon = Icon(icon);
                    });
                  },
                  icon: Icon(icon),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _icon = null;
                      });
                    },
                    child: const Text('Clear icon'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _addCategory,
                    child: const Text('Add category'),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
