import 'package:simple_expense_tracker/data/dto/expense_dto.dart';

abstract interface class LocalExpenseRepository {
  Future<List<ExpenseDto>> getAll();
  Future<List<ExpenseDto>> getRecent([int count = 5]);
  Future<List<ExpenseDto>> getByMonth(DateTime date);
  Future<ExpenseDto?> get(String expenseId);


  Future<ExpenseDto> add(ExpenseDto expense);
  Future<ExpenseDto> remove(ExpenseDto expense);
  Future<void> removeAll();
}
