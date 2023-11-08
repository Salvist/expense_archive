import 'package:realm/realm.dart';
import 'package:money_archive/domain/models/expense_category.dart';

part 'expense_category.g.dart';

@RealmModel()
class _RealmExpenseCategory {
  @PrimaryKey()
  late String name;

  @Indexed()
  late int id;

  late int? iconCodePoint;
}

class CategoryMapper {
  CategoryMapper._();

  static RealmExpenseCategory toRealm(ExpenseCategory category) {
    return RealmExpenseCategory(
      category.name,
      category.id,
      iconCodePoint: category.iconCodePoint,
    );
  }

  static ExpenseCategory toCategory(RealmExpenseCategory realm) {
    return ExpenseCategory(
      name: realm.name,
      iconCodePoint: realm.iconCodePoint,
      id: realm.id,
    );
  }
}
