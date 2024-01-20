import 'package:simple_expense_tracker/data/source/local/realm/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';

class CategoryDto extends ExpenseCategory {
  const CategoryDto({
    required super.name,
    super.iconName,
  });

  factory CategoryDto.fromEntity(ExpenseCategory category) {
    return CategoryDto(
      name: category.name,
      iconName: category.iconName,
    );
  }

  RealmExpenseCategory toRealm() {
    return RealmExpenseCategory(
      name,
      iconName: iconName,
    );
  }

  factory CategoryDto.fromRealm(RealmExpenseCategory category) {
    return CategoryDto(
      name: category.name,
      iconName: category.iconName,
    );
  }
}
