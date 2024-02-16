import 'package:simple_expense_tracker/data/dto/business_dto.dart';
import 'package:simple_expense_tracker/data/dto/category_dto.dart';

abstract interface class LocalBusinessDataSource {
  Future<List<BusinessDto>> getAll();
  Future<List<BusinessDto>> getByCategory(CategoryDto category);
  Future<BusinessDto> get(String name);

  Future<BusinessDto> add(BusinessDto business);

  Future<BusinessDto> edit(BusinessDto editedBusiness);

  Future<BusinessDto> remove(BusinessDto business);
  Future<BusinessDto> removeById(String businessId);
}
