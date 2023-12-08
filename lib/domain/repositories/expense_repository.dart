import 'package:simple_expense_tracker/domain/models/expense.dart';

abstract interface class ExpenseRepository {
  Future<List<Expense>> getAll();

  Future<List<Expense>> getByMonth(DateTime date);

  /// Get recent expenses by the given [count]. Defaults to 5.
  Future<List<Expense>> getRecent([int count = 5]);
  Future<Expense?> get(String expenseId);

  Future<Expense> add(Expense expense);

  /// Remove an expense and return the removed expense
  Future<Expense> remove(Expense expense);

  Future<void> removeAll();
}
