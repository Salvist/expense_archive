import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';

class WatchAmountView extends StatelessWidget {
  final Stream<Amount> watchAmount;
  final Widget title;

  const WatchAmountView({
    super.key,
    required this.title,
    required this.watchAmount,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Amount>(
      stream: watchAmount,
      builder: (context, snapshot) {
        final amount = snapshot.data;
        return Column(
          children: [
            title,
            amount != null
                ? Text(
                    '$amount',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                : const CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
