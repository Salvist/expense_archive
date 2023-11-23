import 'package:simple_expense_tracker/domain/models/amount.dart';

import 'expense_category.dart';

class Expense {
  final String? _id;
  String get id => _id!;

  final ExpenseCategory category;
  final String name;
  final Amount amount;
  final String? note;
  final DateTime paidAt;

  const Expense({
    String? id,
    required this.category,
    required this.name,
    required this.amount,
    this.note,
    required this.paidAt,
  }) : _id = id;

  Expense copyWith({String? id}) {
    return Expense(
      id: id ?? _id,
      category: category,
      name: name,
      amount: amount,
      note: note,
      paidAt: paidAt,
    );
  }
}
