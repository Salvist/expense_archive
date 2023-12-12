import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';

extension ExpenseListExtension on List<Expense> {
  Iterable<Amount> get _amounts => map((e) => e.amount);

  Amount getTotalAmount() => _amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);
}
