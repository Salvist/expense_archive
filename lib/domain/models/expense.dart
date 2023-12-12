import 'package:equatable/equatable.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';

import 'expense_category.dart';

class Expense extends Equatable {
  final String? id;
  final ExpenseCategory category;
  final String name;
  final Amount amount;
  final String? note;
  final DateTime paidAt;

  const Expense({
    this.id,
    required this.category,
    required this.name,
    required this.amount,
    this.note,
    required this.paidAt,
  });

  Expense copyWith({String? id}) {
    return Expense(
      id: id ?? this.id,
      category: category,
      name: name,
      amount: amount,
      note: note,
      paidAt: paidAt,
    );
  }

  @override
  List<Object> get props => [category, name, amount, paidAt];
}
