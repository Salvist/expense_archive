import 'package:simple_expense_tracker/domain/models/business.dart';

abstract interface class BusinessRepository {
  Future<List<Business>> getAll();
  Future<Business> get(String name);

  Future<void> add(Business business);

  Future<Business> edit(Business editedBusiness);
}
