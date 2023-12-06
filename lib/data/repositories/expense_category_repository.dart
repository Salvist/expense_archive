import 'package:simple_expense_tracker/data/dto/category_dto.dart';
import 'package:simple_expense_tracker/data/source/local/local_category_repository.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';

class ExpenseCategoryRepositoryImpl implements ExpenseCategoryRepository {
  final LocalCategoryRepository _local;
  const ExpenseCategoryRepositoryImpl(this._local);

  @override
  Future<void> add(ExpenseCategory category) async {
    final categoryDto = CategoryDto.fromEntity(category);
    await _local.add(categoryDto);
  }

  @override
  Future<List<ExpenseCategory>> getAll() async {
    return await _local.getAll();
  }

  @override
  Future<ExpenseCategory> remove(ExpenseCategory category) async {
    final categoryDto = CategoryDto.fromEntity(category);
    return await _local.remove(categoryDto);
  }
}
