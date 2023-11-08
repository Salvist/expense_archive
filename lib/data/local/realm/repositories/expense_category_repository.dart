import 'dart:developer';

import 'package:realm/realm.dart';
import 'package:money_archive/data/local/realm/models/expense_category.dart';
import 'package:money_archive/domain/models/expense_category.dart';
import 'package:money_archive/domain/repositories/expense_category_repository.dart';

final class RealmExpenseCategoryRepository implements ExpenseCategoryRepository {
  final Realm realm;
  const RealmExpenseCategoryRepository(this.realm);

  @override
  Future<void> add(ExpenseCategory category) async {
    final realmCategory = CategoryMapper.toRealm(category);

    realm.write(() {
      realm.add(realmCategory);
    });
    log('${category.name} has been added.', name: 'Realm');
  }

  @override
  Future<List<ExpenseCategory>> getAll() async {
    final realmCategories = realm.all<RealmExpenseCategory>();
    final categories = realmCategories.map((e) => ExpenseCategory(name: e.name, iconCodePoint: e.iconCodePoint));
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
