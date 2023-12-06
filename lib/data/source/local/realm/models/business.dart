import 'package:realm/realm.dart';

part 'business.g.dart';

@RealmModel()
class _RealmBusiness {
  @PrimaryKey()
  late ObjectId id;

  late String name;
  late String categoryName;
  late String? iconName;
  late double? costPreset;
}
