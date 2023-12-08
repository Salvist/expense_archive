import 'dart:developer' as dev;

import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/dto/expense_dto.dart';
import 'package:simple_expense_tracker/data/source/local/local_expense_repository.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/expense.dart';

final class RealmExpenseRepository implements LocalExpenseRepository {
  final Realm realm;
  const RealmExpenseRepository(this.realm);

  @override
  Future<List<ExpenseDto>> getAll() async {
    final realmExpenses = realm.all<RealmExpense>();
    final expenses = realmExpenses.map(ExpenseDto.fromRealm).toList();
    return expenses;
  }

  @override
  Future<List<ExpenseDto>> getRecent([int count = 5]) async {
    final queryString = 'TRUEPREDICATE SORT(paidAt DESC) LIMIT($count)';
    final realmExpenses = realm.query<RealmExpense>(queryString);
    final recentExpenses = realmExpenses.map(ExpenseDto.fromRealm).toList();
    return recentExpenses;
  }

  @override
  Future<ExpenseDto?> get(String expenseId) async {
    final expense = realm.find<RealmExpense>(expenseId);
    if (expense == null) return null;

    // return ExpenseMapper.toExpense(expense);
    return ExpenseDto.fromRealm(expense);
  }

  @override
  Future<ExpenseDto> add(ExpenseDto expense) async {
    // final realmExpense = ExpenseMapper.toRealm(expense);
    final realmExpense = expense.toRealm();
    realm.write(() {
      realm.add(realmExpense);
    });
    dev.log('Expense has been added.', name: 'Realm');
    // return expense.copyWith(id: realmExpense.id.hexString);
    return ExpenseDto.fromRealm(realmExpense);
  }

  @override
  Future<ExpenseDto> remove(ExpenseDto expense) async {
    final id = ObjectId.fromHexString(expense.id!);
    final realmExpense = realm.find<RealmExpense>(id);
    if (realmExpense != null) {
      realm.write(() {
        realm.delete<RealmExpense>(realmExpense);
      });
    }
    dev.log('Expense ${expense.name} has been removed.', name: 'Realm');
    return expense;
  }

  @override
  Future<void> removeAll() async {
    realm.write(() {
      realm.deleteAll<RealmExpense>();
    });
    dev.log('All expenses has been deleted.', name: 'Realm');
  }

  @override
  Future<List<ExpenseDto>> getByMonth(DateTime date) async {
    final monthDate = DateTime(date.year, date.month);
    final nextMonthDate = DateTime(date.year, date.month + 1);

    const queryString = r'paidAt BETWEEN{$0, $1} SORT(paidAt DESC)';
    final args = [monthDate, nextMonthDate];
    final realmExpenses = realm.query<RealmExpense>(queryString, args);
    final monthlyExpenses = realmExpenses.map(ExpenseDto.fromRealm).toList();
    return monthlyExpenses;
  }
}
