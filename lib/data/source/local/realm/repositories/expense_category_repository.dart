import 'dart:developer';

import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/dto/category_dto.dart';
import 'package:simple_expense_tracker/data/source/local/local_category_repository.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';

final class RealmExpenseCategoryRepository implements LocalCategoryRepository {
  final Realm realm;
  const RealmExpenseCategoryRepository(this.realm);

  @override
  Future<void> add(CategoryDto category) async {
    try {
      final realmCategory = category.toRealm();
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
  Future<void> addAll(List<CategoryDto> categories) async {
    final realmCategories = categories.map((e) => e.toRealm());
    realm.write(() {
      realm.addAll(realmCategories);
    });
    log('${categories.length} categories has been added.');
  }

  @override
  Future<List<CategoryDto>> getAll() async {
    const queryString = r'TRUEPREDICATE SORT(name ASC)';
    final realmCategories = realm.query<RealmExpenseCategory>(queryString);
    final categories = realmCategories.map(CategoryDto.fromRealm);

    log('${categories.length} categories has been loaded.', name: 'Realm');
    return categories.toList();
  }

  @override
  Future<CategoryDto> remove(CategoryDto category) async {
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
