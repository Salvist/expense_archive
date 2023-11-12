import 'package:money_archive/domain/models/business.dart';

abstract interface class BusinessRepository {
  Future<List<Business>> getAll();
  Future<Business> get(String name);

  Future<void> add(Business business);

  Future<Business> edit(Business editedBusiness);
}
