import 'package:simple_expense_tracker/data/dto/expense_dto.dart';

abstract interface class LocalExpenseRepository {
  Future<List<ExpenseDto>> getAll();
  Future<ExpenseDto?> get(String expenseId);
  Future<ExpenseDto> add(ExpenseDto expense);
  Future<ExpenseDto> remove(ExpenseDto expense);
  Future<void> removeAll();
}
