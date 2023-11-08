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
