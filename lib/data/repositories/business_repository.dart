import 'package:simple_expense_tracker/data/dto/business_dto.dart';
import 'package:simple_expense_tracker/data/dto/category_dto.dart';
import 'package:simple_expense_tracker/data/source/local/local_business_repository.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/business_repository.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final LocalBusinessDataSource _local;
  const BusinessRepositoryImpl(this._local);

  @override
  Future<Business> add(Business business) async {
    final businessDto = BusinessDto.fromEntity(business);
    return await _local.add(businessDto);
  }

  @override
  Future<void> addAll(List<Business> businesses) async {
    final businessesDto = businesses.map(BusinessDto.fromEntity).toList();
    await _local.addAll(businessesDto);
  }

  @override
  Future<Business> edit(Business editedBusiness) async {
    final businessDto = BusinessDto.fromEntity(editedBusiness);
    return await _local.edit(businessDto);
  }

  @override
  Future<Business> get(String name) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Business>> getAll() async {
    return await _local.getAll();
  }

  @override
  Future<List<Business>> getByCategory(ExpenseCategory category) async {
    final categoryDto = CategoryDto.fromEntity(category);
    return await _local.getByCategory(categoryDto);
  }

  @override
  Future<Business> remove(Business business) async {
    final businessDto = BusinessDto.fromEntity(business);
    await _local.remove(businessDto);
    return business;
  }

  @override
  Future<Business> removeById(String businessId) {
    // TODO: implement removeById
    throw UnimplementedError();
  }
}
