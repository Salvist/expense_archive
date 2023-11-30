import 'dart:developer' as dev;

import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/local/realm/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

final class RealmExpenseRepository implements ExpenseRepository {
  final Realm realm;
  const RealmExpenseRepository(this.realm);

  @override
  Future<Expense?> get(String expenseId) async {
    final expense = realm.find<RealmExpense>(expenseId);
    if (expense == null) return null;

    return ExpenseMapper.toExpense(expense);
  }

  @override
  Future<List<Expense>> getAll() async {
    final realmExpenses = realm.all<RealmExpense>();
    final expenses = realmExpenses.map(ExpenseMapper.toExpense).toList();
    final dates = expenses.map((e) => e.paidAt);
    return expenses;
  }

  @override
  Future<Expense> add(Expense expense) async {
    final realmExpense = ExpenseMapper.toRealm(expense);
    realm.write(() {
      realm.add(realmExpense);
    });
    dev.log('Expense has been added.', name: 'Realm');
    return expense.copyWith(id: realmExpense.id.hexString);
  }

  @override
  Future<Expense> remove(Expense expense) async {
    final id = ObjectId.fromHexString(expense.id);
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
}
