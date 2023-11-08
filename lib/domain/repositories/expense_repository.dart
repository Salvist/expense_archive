import 'package:money_archive/domain/models/expense.dart';

abstract interface class ExpenseRepository {
  Future<List<Expense>> getAll();
  Future<Expense?> get(String expenseId);

  Future<Expense> add(Expense expense);

  /// Remove an expense and return the removed expense
  Future<Expense> remove(Expense expense);

  Future<void> removeAll();
}
