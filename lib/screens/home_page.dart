import 'package:flutter/material.dart';

import 'package:money_archive/providers/expenses_provider.dart';
import 'package:money_archive/screens/add_expense_page.dart';
import 'package:money_archive/screens/all_expense_page.dart';
import 'package:money_archive/utils/extensions/date_time_extension.dart';
import 'package:money_archive/widgets/dialogs/expense_info_dialog.dart';
import 'package:money_archive/widgets/expense_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentDate = DateTime.now();

    final expenses = InheritedExpenses.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: theme.colorScheme.primaryContainer,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Richie!',
                    style: theme.textTheme.headlineSmall,
                  ),
                  Text(currentDate.format('yMMMd')),
                  const SizedBox(height: 16),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentDate.monthName,
                                // style: theme.textTheme.headlineSmall,
                              ),
                              Text(
                                '\$${expenses.monthly}',
                                style: theme.textTheme.headlineLarge,
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          indent: 4,
                          endIndent: 4,
                          color: theme.colorScheme.primary,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Today'),
                              Text(
                                '\$${expenses.today}',
                                style: theme.textTheme.headlineLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Recent Expenses'),
              subtitle: const Text('Showing 5 recent expenses'),
              trailing: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AllExpensePage()));
                  // context.push('/home/all_expenses');
                },
                child: const Text('View all'),
              ),
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...expenses.recent.map(
                  (expense) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ExpenseTile(
                      expense: expense,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ExpenseInfoDialog(expense),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpensePage()));
          // context.push('/home/add_expense');
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add expense'),
      ),
    );
  }
}
