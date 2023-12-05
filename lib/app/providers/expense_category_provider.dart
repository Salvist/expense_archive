import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';

class CategoryProvider extends InheritedWidget {
  final List<ExpenseCategory> data;

  const CategoryProvider({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);

  static CategoryProvider of(BuildContext context) {
    final CategoryProvider? result = context.dependOnInheritedWidgetOfExactType<CategoryProvider>();
    assert(result != null, 'No ExpenseCategories found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CategoryProvider oldWidget) {
    return true;
  }
}

class CategoryNotifier extends StatefulWidget {
  final ExpenseCategoryRepository repository;
  final Widget child;

  const CategoryNotifier({
    super.key,
    required this.repository,
    required this.child,
  });

  static CategoryNotifierState of(BuildContext context) {
    return context.findAncestorStateOfType<CategoryNotifierState>()!;
  }

  @override
  State<CategoryNotifier> createState() => CategoryNotifierState();
}

class CategoryNotifierState extends State<CategoryNotifier> {
  final _categories = <ExpenseCategory>[];

  @override
  void initState() {
    firstSetup();
    super.initState();
  }

  void firstSetup() async {
    final categories = await widget.repository.getAll();
    if (categories.isEmpty) {
      for (final category in ExpenseCategory.defaultCategories) {
        await widget.repository.add(category);
      }
      setState(() {
        _categories.addAll(_categories);
      });
    } else {
      setState(() {
        _categories.addAll(categories);
      });
    }
  }

  bool contains(String name) {
    final names = _categories.map((e) => e.name);
    return names.contains(name);
  }

  Future<ExpenseCategory> addCategory(ExpenseCategory category) async {
    await widget.repository.add(category.copyWith(id: _categories.last.id + 1));
    setState(() {
      _categories.add(category);
    });
    return category;
  }

  void removeCategory(ExpenseCategory category) async {
    await widget.repository.remove(category);
    setState(() {
      _categories.remove(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CategoryProvider(
      data: _categories,
      child: widget.child,
    );
  }
}
