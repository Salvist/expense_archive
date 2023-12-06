import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/business.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';

class BusinessDto extends Business {
  const BusinessDto._({
    required super.name,
    required super.categoryName,
    super.costPreset,
  });

  factory BusinessDto.fromEntity(Business business) {
    return BusinessDto._(
      name: business.name,
      categoryName: business.categoryName,
      costPreset: business.costPreset,
    );
  }

  factory BusinessDto.fromRealm(RealmBusiness business) {
    return BusinessDto._(
      name: business.name,
      categoryName: business.categoryName,
      costPreset: business.costPreset != null ? Amount(business.costPreset!) : null,
    );
  }

  RealmBusiness toRealm() {
    return RealmBusiness(
      ObjectId(),
      name,
      categoryName,
      costPreset: costPreset?.value,
    );
  }
}
