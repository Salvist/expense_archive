import 'package:simple_expense_tracker/data/dto/expense_dto.dart';
import 'package:simple_expense_tracker/data/source/local/local_expense_repository.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final LocalExpenseRepository _local;
  // final RemoteDatabase? _remoteDatabase;

  const ExpenseRepositoryImpl(this._local);

  @override
  Future<Expense> add(Expense expense) async {
    final expenseDto = ExpenseDto.fromEntity(expense);
    return await _local.add(expenseDto);
  }

  @override
  Future<Expense?> get(String expenseId) async {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> getAll() async {
    return await _local.getAll();
  }

  @override
  Future<Expense> remove(Expense expense) async {
    final expenseDto = ExpenseDto.fromEntity(expense);
    return await _local.remove(expenseDto);
  }

  @override
  Future<void> removeAll() async {
    return await _local.removeAll();
  }

  @override
  Future<List<Expense>> getByMonth(DateTime date) async {
    return await _local.getByMonth(date);
  }

  @override
  Future<List<Expense>> getRecent([int count = 5]) async {
    return await _local.getRecent(count);
  }
}
