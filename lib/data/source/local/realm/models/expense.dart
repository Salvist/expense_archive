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
