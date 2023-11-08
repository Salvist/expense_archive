import 'package:money_archive/domain/models/expense_category.dart';

abstract interface class ExpenseCategoryRepository {
  Future<List<ExpenseCategory>> getAll();

  Future<void> add(ExpenseCategory category);

  Future<ExpenseCategory> remove(ExpenseCategory category);
}
