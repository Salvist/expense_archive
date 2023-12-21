import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/repositories/business_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

class RepositoryProvider extends InheritedWidget {
  final ExpenseRepository expenseRepository;
  final ExpenseCategoryRepository categoryRepository;
  final BusinessRepository businessRepository;

  const RepositoryProvider({
    super.key,
    required this.expenseRepository,
    required this.categoryRepository,
    required this.businessRepository,
    required super.child,
  });

  static ExpenseRepository expenseOf(BuildContext context) => of(context).expenseRepository;
  static ExpenseCategoryRepository categoryOf(BuildContext context) => of(context).categoryRepository;
  static BusinessRepository businessOf(BuildContext context) => of(context).businessRepository;

  static RepositoryProvider of(BuildContext context) {
    // final RepositoryProvider? result = context.dependOnInheritedWidgetOfExactType<RepositoryProvider>();
    final RepositoryProvider? result = context.findAncestorWidgetOfExactType<RepositoryProvider>();
    assert(result != null, 'No RepositoryProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
