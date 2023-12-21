import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/repository_provider.dart';
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
  late final ExpenseCategoryRepository _categoryRepository;
  var _categories = <ExpenseCategory>[];
  final _controller = TextEditingController();

  bool _isLoaded = false;

  @override
  void initState() {
    _categoryRepository = RepositoryProvider.categoryOf(context);
    _categoryRepository.getAll().then((categories) {
      try {
        _categories = categories;
      } finally {
        setState(() {
          _isLoaded = true;
        });
      }
    });

    super.initState();
  }

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
    Icon leadingIcon;
    if (widget.selectedCategory != null) {
      leadingIcon = Icon(widget.selectedCategory!.icon);
    } else {
      leadingIcon = const Icon(Icons.category_rounded);
    }

    return DropdownMenu(
      enabled: _isLoaded,
      controller: _controller,
      width: widget.width,
      leadingIcon: leadingIcon,
      label: const Text('Category'),
      errorText: widget.errorText,
      onSelected: widget.onChanged,
      dropdownMenuEntries: _categories.map((category) {
        return DropdownMenuEntry(
          leadingIcon: Icon(categoryIcons[category.iconName]),
          value: category,
          label: category.name,
        );
      }).toList(),
    );
  }
}
