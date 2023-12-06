import 'package:simple_expense_tracker/data/dto/business_dto.dart';

abstract interface class LocalBusinessRepository {
  Future<List<BusinessDto>> getAll();
  Future<BusinessDto> get(String name);

  Future<void> add(BusinessDto business);

  Future<BusinessDto> edit(BusinessDto editedBusiness);
}
