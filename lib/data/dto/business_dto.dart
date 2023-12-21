import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/business.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';

class BusinessDto extends Business {
  const BusinessDto._({
    required super.name,
    required super.categoryName,
    super.amountPreset,
  });

  factory BusinessDto.fromEntity(Business business) {
    return BusinessDto._(
      name: business.name,
      categoryName: business.categoryName,
      amountPreset: business.amountPreset,
    );
  }

  factory BusinessDto.fromRealm(RealmBusiness business) {
    return BusinessDto._(
      name: business.name,
      categoryName: business.categoryName,
      amountPreset: business.amountPreset != null ? Amount(business.amountPreset!) : null,
    );
  }

  RealmBusiness toRealm() {
    return RealmBusiness(
      ObjectId(),
      name,
      categoryName,
      amountPreset: amountPreset?.value,
    );
  }
}
