import 'package:flutter/material.dart';
import 'package:money_archive/domain/models/expense_category.dart';
import 'package:money_archive/providers/expense_category_provider.dart';
import 'package:money_archive/utils/code_point_to_icon.dart';

class ExpenseCategoryDropdown extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final categories = ExpenseCategories.of(context);

    Icon leadingIcon;
    if (selectedCategory != null) {
      leadingIcon = Icon(getIconData(selectedCategory!.iconCodePoint));
    } else {
      leadingIcon = const Icon(Icons.category_rounded);
    }

    return DropdownMenu(
      width: width,
      leadingIcon: leadingIcon,
      label: const Text('Category'),
      errorText: errorText,
      onSelected: onChanged,
      dropdownMenuEntries: categories.map((category) {
        return DropdownMenuEntry(
          leadingIcon: Icon(getIconData(category.iconCodePoint)),
          value: category,
          label: category.name,
        );
      }).toList(),
    );
  }
}
