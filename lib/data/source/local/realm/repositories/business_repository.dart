import 'dart:developer' as dev;

import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/dto/business_dto.dart';
import 'package:simple_expense_tracker/data/source/local/local_business_repository.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/business.dart';

final class RealmBusinessRepository implements LocalBusinessRepository {
  final Realm _realm;
  const RealmBusinessRepository(this._realm);

  @override
  Future<void> add(BusinessDto business) async {
    try {
      final businessExist = _realm.query<RealmBusiness>(
        'name == \$0 AND categoryName == \$1',
        [business.name, business.categoryName],
      ).isNotEmpty;

      if (businessExist) {
        throw Exception('Business ${business.name} already exist in category ${business.categoryName}');
      }

      final realmBusiness = business.toRealm();

      _realm.write(() {
        _realm.add(realmBusiness);
      });

      dev.log('${realmBusiness.name} has been added.', name: 'Realm');
    } on RealmException catch (e) {
      if (e.message.contains('1013')) {
        // throw DuplicateCategoryException(category.name);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<BusinessDto> get(String name) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<BusinessDto>> getAll() async {
    final realmBusinesses = _realm.all<RealmBusiness>();
    final businesses = realmBusinesses.map(BusinessDto.fromRealm).toList();
    dev.log('${businesses.length} businesses has been loaded.', name: 'Realm');
    return businesses;
  }

  @override
  Future<BusinessDto> edit(BusinessDto editedBusiness) async {
    final results = _realm.query<RealmBusiness>(
      'name == \$0 AND categoryName == \$1',
      [editedBusiness.name, editedBusiness.categoryName],
    );
    if (results.isEmpty) return editedBusiness;
    final realmBusiness = results.first;
    final oldName = realmBusiness.name;
    final oldCost = realmBusiness.costPreset;
    _realm.write(() {
      realmBusiness.name = editedBusiness.name;
      realmBusiness.costPreset = editedBusiness.costPreset?.value;
    });
    dev.log(
      'Name: $oldName --> ${editedBusiness.costPreset}\nCost: $oldCost --> ${editedBusiness.costPreset}',
      name: 'Realm',
    );
    return editedBusiness;
  }
}
