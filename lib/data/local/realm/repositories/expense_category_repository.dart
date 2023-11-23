import 'dart:developer';

import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/local/realm/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';

final class RealmExpenseCategoryRepository implements ExpenseCategoryRepository {
  final Realm realm;
  const RealmExpenseCategoryRepository(this.realm);

  @override
  Future<void> add(ExpenseCategory category) async {
    try {
      final realmCategory = CategoryMapper.toRealm(category);
      realm.write(() {
        realm.add(realmCategory);
      });
      log('${category.name} has been added.', name: 'Realm');
    } on RealmException catch (e) {
      if (e.message.contains('1013')) {
        throw DuplicateCategoryException(category.name);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<List<ExpenseCategory>> getAll() async {
    final realmCategories = realm.all<RealmExpenseCategory>();
    final categories = realmCategories.map((e) => ExpenseCategory(name: e.name, iconName: e.iconName));
    log('${categories.length} categories has been loaded.', name: 'Realm');
    return categories.toList();
  }

  @override
  Future<ExpenseCategory> remove(ExpenseCategory category) async {
    final data = realm.find<RealmExpenseCategory>(category.name);
    if (data == null) {
      log('Category ${category.name} does not exist in database', name: 'Realm');
      return category;
    }
    realm.write(() {
      realm.delete(data);
    });
    log('Category ${category.name} has been removed.', name: 'Realm');
    return category;
  }
}
