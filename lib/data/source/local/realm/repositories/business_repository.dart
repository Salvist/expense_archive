import 'dart:developer' as dev;

import 'package:realm/realm.dart';
import 'package:simple_expense_tracker/data/dto/business_dto.dart';
import 'package:simple_expense_tracker/data/dto/category_dto.dart';
import 'package:simple_expense_tracker/data/source/local/local_business_repository.dart';
import 'package:simple_expense_tracker/data/source/local/realm/models/business.dart';

final class RealmBusinessDataSource implements LocalBusinessDataSource {
  final Realm _realm;
  const RealmBusinessDataSource(this._realm);

  @override
  Future<BusinessDto> add(BusinessDto business) async {
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
      return BusinessDto.fromRealm(realmBusiness);
    } on RealmException catch (e) {
      if (e.message.contains('1013')) {
        // throw DuplicateCategoryException(category.name);
      } else {
        rethrow;
      }
      rethrow;
    }
  }

  @override
  Future<void> addAll(Iterable<BusinessDto> businesses) async {
    final realmBusinesses = businesses.map((e) => e.toRealm());

    _realm.write(() {
      _realm.addAll(realmBusinesses);
    });
  }

  @override
  Future<BusinessDto> get(String name) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<BusinessDto>> getAll() async {
    final realmBusinesses = _realm.query<RealmBusiness>(r'TRUEPREDICATE SORT(name ASC)');
    final businesses = realmBusinesses.map(BusinessDto.fromRealm).toList();
    dev.log('${businesses.length} businesses has been loaded.', name: 'Realm');
    return businesses;
  }

  @override
  Future<List<BusinessDto>> getByCategory(CategoryDto category) async {
    const query = "categoryName == \$0";
    final args = [category.name];
    final realmBusiness = _realm.query<RealmBusiness>(query, args);
    final businesses = realmBusiness.map(BusinessDto.fromRealm).toList();
    dev.log('${businesses.length} businesses has been loaded.', name: 'Realm');
    return businesses;
  }

  @override
  Future<BusinessDto> edit(BusinessDto editedBusiness) async {
    final realmBusiness = _realm.find<RealmBusiness>(ObjectId.fromHexString(editedBusiness.id));

    if (realmBusiness == null) {
      dev.log('No business found ${editedBusiness.name} ${editedBusiness.categoryName} ', name: 'Realm');
      return editedBusiness;
    }

    final oldName = realmBusiness.name;
    final oldCost = realmBusiness.amountPreset;
    _realm.write(() {
      realmBusiness.name = editedBusiness.name;
      realmBusiness.amountPreset = editedBusiness.amountPreset?.value;
    });
    dev.log(
      'Name: $oldName --> ${editedBusiness.name}\nCost: $oldCost --> ${editedBusiness.amountPreset}',
      name: 'Realm',
    );
    return editedBusiness;
  }

  @override
  Future<BusinessDto> remove(BusinessDto business) async {
    final realmBusiness = _realm.find<RealmBusiness>(ObjectId.fromHexString(business.id));

    if (realmBusiness == null) {
      dev.log('$business does not exist in the database.', name: 'Realm');
      return business;
    }

    _realm.write(() {
      _realm.delete<RealmBusiness>(realmBusiness);
    });
    dev.log('$business has been removed.', name: 'Realm');
    return business;
  }

  @override
  Future<BusinessDto> removeById(String businessId) {
    // TODO: implement removeById
    throw UnimplementedError();
  }
}
