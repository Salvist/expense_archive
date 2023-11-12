import 'package:money_archive/domain/models/business.dart';
import 'package:money_archive/domain/models/amount.dart';
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

class BusinessMapper {
  BusinessMapper._();

  static Business toBusiness(RealmBusiness realm) {
    return Business(
      name: realm.name,
      categoryName: realm.categoryName,
      costPreset: realm.costPreset != null ? Amount(realm.costPreset!) : null,
    );
  }

  static RealmBusiness toRealm(Business business) {
    return RealmBusiness(
      ObjectId(),
      business.name,
      business.categoryName,
      costPreset: business.costPreset?.value,
    );
  }
}
