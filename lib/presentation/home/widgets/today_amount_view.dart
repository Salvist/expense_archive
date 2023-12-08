import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/presentation/home/home_provider.dart';

class TodayAmountView extends StatelessWidget {
  const TodayAmountView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final monthlyExpenses = HomeProvider.monthlyExpensesOf(context);
    final todayExpenses = monthlyExpenses.where((expense) => DateUtils.isSameDay(currentDate, expense.paidAt));
    final amounts = todayExpenses.map((element) => element.amount);
    final todayAmount = amounts.fold(Amount.zero, (previousValue, element) => previousValue + element);

    return Column(
      children: [
        const Text('Today'),
        Text(
          '$todayAmount',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
