import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';

class CategoryExpense {
  final ExpenseCategory category;
  final List<Expense> expenses;

  const CategoryExpense({
    required this.category,
    required this.expenses,
  });

  Amount get totalAmount {
    final amounts = expenses.map((e) => e.amount);
    return amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
  }
}
