import 'package:simple_expense_tracker/data/dto/category_dto.dart';

abstract interface class LocalCategoryRepository {
  Future<List<CategoryDto>> getAll();

  Future<void> add(CategoryDto category);

  Future<CategoryDto> remove(CategoryDto category);
}
