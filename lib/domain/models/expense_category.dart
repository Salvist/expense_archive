class ExpenseCategory {
  final String name;
  final int id;
  final int? iconCodePoint;

  const ExpenseCategory({
    required this.name,
    this.id = 0,
    this.iconCodePoint,
  });
}

class DuplicateCategoryException implements Exception {
  final String name;
  const DuplicateCategoryException(this.name);

  String get message => 'Category "$name" already exist.';

  @override
  String toString() => 'DuplicateCategoryException: $message';
}
