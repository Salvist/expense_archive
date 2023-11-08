import 'expense_category.dart';

class Expense {
  final String? _id;
  String get id => _id!;

  final ExpenseCategory category;
  final String name;
  final double cost;
  final String? note;
  final DateTime paidAt;

  const Expense({
    String? id,
    required this.category,
    required this.name,
    required this.cost,
    this.note,
    required this.paidAt,
  }) : _id = id;

  Expense copyWith({String? id}) {
    return Expense(
      id: id ?? _id,
      category: category,
      name: name,
      cost: cost,
      note: note,
      paidAt: paidAt,
    );
  }
}
