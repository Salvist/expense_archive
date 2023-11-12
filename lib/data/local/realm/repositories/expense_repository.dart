import 'dart:developer' as dev;

import 'package:money_archive/domain/models/amount.dart';
import 'package:realm/realm.dart';
import 'package:money_archive/data/local/realm/models/expense.dart';

import 'package:money_archive/domain/models/expense.dart';
import 'package:money_archive/domain/models/expense_category.dart';
import 'package:money_archive/domain/repositories/expense_repository.dart';

final class RealmExpenseRepository implements ExpenseRepository {
  final Realm realm;
  const RealmExpenseRepository(this.realm);

  @override
  Future<Expense?> get(String expenseId) async {
    final expense = realm.find<RealmExpense>(expenseId);
    if (expense == null) return null;

    return Expense(
      name: expense.name,
      category: ExpenseCategory(
        name: expense.categoryName,
        iconName: expense.categoryIconName,
      ),
      amount: Amount(expense.cost),
      note: expense.note,
      paidAt: expense.paidAt,
    );
  }

  @override
  Future<List<Expense>> getAll() async {
    final realmExpenses = realm.all<RealmExpense>();
    final expenses = realmExpenses
        .map((expense) => Expense(
              name: expense.name,
              category: ExpenseCategory(
                name: expense.categoryName,
                iconName: expense.categoryIconName,
              ),
              amount: Amount(expense.cost),
              note: expense.note,
              paidAt: expense.paidAt,
            ))
        .toList();
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
  }
}
