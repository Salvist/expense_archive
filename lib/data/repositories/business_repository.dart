import 'package:simple_expense_tracker/data/dto/business_dto.dart';
import 'package:simple_expense_tracker/data/source/local/local_business_repository.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/repositories/business_repository.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final LocalBusinessRepository _local;
  const BusinessRepositoryImpl(this._local);

  @override
  Future<void> add(Business business) async {
    final businessDto = BusinessDto.fromEntity(business);
    return await _local.add(businessDto);
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
}
