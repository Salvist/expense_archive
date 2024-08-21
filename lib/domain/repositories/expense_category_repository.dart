import 'package:simple_expense_tracker/domain/models/expense_category.dart';

abstract interface class ExpenseCategoryRepository {
  Future<List<ExpenseCategory>> getAll();

  Future<void> add(ExpenseCategory category);
  Future<void> addAll(List<ExpenseCategory> categories);

  Future<ExpenseCategory> remove(ExpenseCategory category);
}
