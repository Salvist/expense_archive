import 'package:simple_expense_tracker/data/dto/expense_dto.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';

abstract interface class LocalExpenseRepository {
  Future<List<ExpenseDto>> getAll();

  Future<List<ExpenseDto>> getRecent([int count = 5]);
  Stream<List<ExpenseDto>> watchRecent([int count = 5]);

  Future<List<ExpenseDto>> getByMonth(DateTime date);
  Stream<Amount> watchMonthlyAmount(DateTime date);

  Future<List<ExpenseDto>> getByWeek(DateTime date);
  Stream<List<ExpenseDto>> watchWeeklyExpenses(DateTime date);

  Future<DateTime?> getStartDate();
  Future<(DateTime, DateTime)> getStartAndEndDates();
  Future<ExpenseDto?> get(String expenseId);

  Stream<Amount> watchTodayAmount();

  Future<ExpenseDto> add(ExpenseDto expense);
  Future<ExpenseDto> remove(ExpenseDto expense);
  Future<void> removeAll();
}
