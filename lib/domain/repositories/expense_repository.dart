import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';

abstract interface class ExpenseRepository {
  Future<List<Expense>> getAll();

  Future<List<Expense>> getByMonth(DateTime date);
  Stream<Amount> watchMonthlyAmount(DateTime date);

  Future<List<Expense>> getByWeek(DateTime date);

  /// Get recent expenses by the given [count]. Defaults to 5.
  Future<List<Expense>> getRecent([int count = 5]);
  Stream<List<Expense>> watchRecent([int count = 5]);

  /// Get the start and end date of your expenses journey.
  Future<({DateTime start, DateTime end})> getStartAndEndDates();
  Future<Expense?> get(String expenseId);

  Stream<Amount> watchTodayAmount();

  Future<Expense> add(Expense expense);

  /// Remove an expense and return the removed expense
  Future<Expense> remove(Expense expense);

  Future<void> removeAll();
}
