import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
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
  late String? categoryIconName;
}

class ExpenseMapper {
  ExpenseMapper._();

  static RealmExpense toRealm(Expense expense) {
    return RealmExpense(
      ObjectId(),
      expense.name,
      expense.amount.value,
      expense.paidAt.toUtc(),
      expense.category.name,
      categoryIconName: expense.category.iconName,
      note: expense.note,
    );
  }

  static Expense toExpense(RealmExpense realm) {
    return Expense(
      category: ExpenseCategory(
        name: realm.categoryName,
        iconName: realm.categoryIconName,
      ),
      name: realm.name,
      amount: Amount(realm.cost),
      note: realm.note,
      paidAt: realm.paidAt.toLocal(),
    );
  }
}
