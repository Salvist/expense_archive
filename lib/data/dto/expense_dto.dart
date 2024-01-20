import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/dto/category_dto.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';

class ExpenseDto extends Expense {
  const ExpenseDto({
    super.id,
    required super.category,
    required super.name,
    required super.amount,
    required super.paidAt,
  });

  factory ExpenseDto.fromEntity(Expense expense) {
    return ExpenseDto(
      category: expense.category,
      name: expense.name,
      amount: expense.amount,
      paidAt: expense.paidAt,
    );
  }

  factory ExpenseDto.fromRealm(RealmExpense realmExpense) {
    return ExpenseDto(
      id: realmExpense.id.hexString,
      category: CategoryDto(
        name: realmExpense.categoryName,
        iconName: realmExpense.categoryIconName,
      ),
      name: realmExpense.name,
      amount: Amount(realmExpense.amount),
      paidAt: realmExpense.paidAt.toLocal(),
    );
  }

  RealmExpense toRealm() {
    return RealmExpense(
      ObjectId(),
      name,
      amount.value,
      paidAt.toUtc(),
      category.name,
      categoryIconName: category.iconName,
      note: note,
    );
  }
}
