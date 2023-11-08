import 'package:flutter/material.dart';
import 'package:money_archive/domain/models/expense_category.dart';
import 'package:money_archive/domain/repositories/expense_category_repository.dart';

final defaultCategories = <ExpenseCategory>[
  ExpenseCategory(
    id: 1,
    name: 'Food',
    iconCodePoint: Icons.restaurant_rounded.codePoint,
  ),
  ExpenseCategory(
    id: 2,
    name: 'Subway',
    iconCodePoint: Icons.subway_rounded.codePoint,
  ),
  ExpenseCategory(
    id: 3,
    name: 'Electricity',
    iconCodePoint: Icons.bolt_rounded.codePoint,
  ),
  ExpenseCategory(
    id: 4,
    name: 'Clothes',
    iconCodePoint: Icons.checkroom_rounded.codePoint,
  ),
];

class ExpenseCategories extends InheritedWidget {
  final List<ExpenseCategory> data;

  const ExpenseCategories({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);

  static List<ExpenseCategory> of(BuildContext context) {
    final ExpenseCategories? result = context.dependOnInheritedWidgetOfExactType<ExpenseCategories>();
    assert(result != null, 'No ExpenseCategories found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(ExpenseCategories oldWidget) {
    return true;
  }
}

class ExpenseCategoryProvider extends StatefulWidget {
  final ExpenseCategoryRepository repository;
  final Widget child;

  const ExpenseCategoryProvider({
    super.key,
    required this.repository,
    required this.child,
  });

  static ExpenseCategoryProviderState of(BuildContext context) {
    return context.findAncestorStateOfType<ExpenseCategoryProviderState>()!;
  }

  @override
  State<ExpenseCategoryProvider> createState() => ExpenseCategoryProviderState();
}

class ExpenseCategoryProviderState extends State<ExpenseCategoryProvider> {
  final _categories = <ExpenseCategory>[];

  @override
  void initState() {
    firstSetup();
    super.initState();
  }

  void firstSetup() async {
    final categories = await widget.repository.getAll();
    if (categories.isEmpty) {
      for (final category in defaultCategories) {
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

  void addCategory({required String name, int? iconData}) async {
    final category = ExpenseCategory(
      id: _categories.last.id + 1,
      name: name,
      iconCodePoint: iconData,
    );

    await widget.repository.add(category);

    setState(() {
      _categories.add(category);
    });
  }

  void removeCategory(ExpenseCategory category) async {
    await widget.repository.remove(category);
    setState(() {
      _categories.remove(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpenseCategories(
      data: _categories,
      child: widget.child,
    );
  }
}
