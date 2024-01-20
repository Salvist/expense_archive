import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';

abstract interface class BusinessRepository {
  Future<List<Business>> getAll();
  Future<List<Business>> getByCategory(ExpenseCategory category);
  Future<Business> get(String name);

  Future<void> add(Business business);

  Future<Business> edit(Business editedBusiness);
}
