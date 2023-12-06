import 'package:realm/realm.dart';

part 'expense_category.g.dart';

@RealmModel()
class _RealmExpenseCategory {
  @PrimaryKey()
  late String name;

  @Indexed()
  late int id;

  late String? iconName;
}
