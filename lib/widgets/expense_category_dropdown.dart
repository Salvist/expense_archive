import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/app/providers/expense_category_provider.dart';
import 'package:simple_expense_tracker/utils/available_icons.dart';

class ExpenseCategoryDropdown extends StatefulWidget {
  final double? width;
  final String? errorText;
  final ExpenseCategory? selectedCategory;
  final void Function(ExpenseCategory? category) onChanged;

  const ExpenseCategoryDropdown({
    super.key,
    this.width,
    this.errorText,
    this.selectedCategory,
    required this.onChanged,
  });

  @override
  State<ExpenseCategoryDropdown> createState() => _ExpenseCategoryDropdownState();
}

class _ExpenseCategoryDropdownState extends State<ExpenseCategoryDropdown> {
  final _controller = TextEditingController();

  @override
  void didUpdateWidget(ExpenseCategoryDropdown oldWidget) {
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      setState(() {
        _controller.text = widget.selectedCategory?.name ?? '';
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ExpenseCategories.of(context);

    Icon leadingIcon;
    if (widget.selectedCategory != null) {
      leadingIcon = Icon(widget.selectedCategory!.icon);
    } else {
      leadingIcon = const Icon(Icons.category_rounded);
    }

    return DropdownMenu(
      controller: _controller,
      width: widget.width,
      leadingIcon: leadingIcon,
      label: const Text('Category'),
      errorText: widget.errorText,
      onSelected: widget.onChanged,
      dropdownMenuEntries: categories.map((category) {
        return DropdownMenuEntry(
          leadingIcon: Icon(categoryIcons[category.iconName]),
          value: category,
          label: category.name,
        );
      }).toList(),
    );
  }
}
