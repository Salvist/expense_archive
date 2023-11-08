import 'package:money_archive/domain/models/expense.dart';
import 'package:money_archive/domain/models/expense_category.dart';
import 'package:realm/realm.dart';

part 'expense.g.dart';

@RealmModel()
class _RealmExpense {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  late double cost;
  late String? note;
  late DateTime paidAt;

  late String categoryName;
  late int? categoryIconCodePoint;
}

class ExpenseMapper {
  ExpenseMapper._();

  static RealmExpense toRealm(Expense expense) {
    return RealmExpense(
      ObjectId(),
      expense.name,
      expense.cost,
      expense.paidAt,
      expense.category.name,
      categoryIconCodePoint: expense.category.iconCodePoint,
      note: expense.note,
    );
  }

  static Expense toExpense(RealmExpense realm) {
    return Expense(
      category: ExpenseCategory(
        name: realm.categoryName,
        iconCodePoint: realm.categoryIconCodePoint,
      ),
      name: realm.name,
      cost: realm.cost,
      note: realm.note,
      paidAt: realm.paidAt,
    );
  }
}
