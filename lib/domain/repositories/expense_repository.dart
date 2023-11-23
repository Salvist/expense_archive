import 'package:simple_expense_tracker/domain/models/expense.dart';

abstract interface class ExpenseRepository {
  Future<List<Expense>> getAll();
  Future<Expense?> get(String expenseId);

  Future<Expense> add(Expense expense);

  /// Remove an expense and return the removed expense
  Future<Expense> remove(Expense expense);

  Future<void> removeAll();
}
