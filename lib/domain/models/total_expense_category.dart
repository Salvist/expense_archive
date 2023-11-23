import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';

class CategoryExpenses {
  final ExpenseCategory category;
  final List<Expense> expenses;

  const CategoryExpenses({
    required this.category,
    required this.expenses,
  });

  Amount get totalAmount {
    final amounts = expenses.map((e) => e.amount);
    return amounts.fold(Amount.zero, (value, element) => value + element);
  }
}
