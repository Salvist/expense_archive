import 'package:realm/realm.dart';

part 'expense_category.g.dart';

@RealmModel()
class _RealmExpenseCategory {
  @PrimaryKey()
  late String name;

  late String? iconName;
}
