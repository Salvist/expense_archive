import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/presentation/home/home_provider.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class MonthlyAmountView extends StatelessWidget {
  const MonthlyAmountView({super.key});

  @override
  Widget build(BuildContext context) {
    final monthlyAmount = HomeProvider.monthlyAmountOf(context);
    final currentDate = DateTime.now();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(currentDate.monthName),
        Text(
          '$monthlyAmount',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
