import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/expense_provider.dart';
import 'package:simple_expense_tracker/presentation/home/home_provider.dart';
import 'package:simple_expense_tracker/screens/expense/add_expense_page.dart';
import 'package:simple_expense_tracker/screens/expense/all_expense_page.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';
import 'package:simple_expense_tracker/widgets/dialogs/expense_info_dialog.dart';
import 'package:simple_expense_tracker/widgets/expense_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Object route(BuildContext context) {
    final route = MaterialPageRoute(builder: (context) {
      return const HomePage();
    });
    return route;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentDate = DateTime.now();
    final expenseProvider = ExpenseProvider.of(context);
    // final recentExpenses = HomeProvider.recentExpensesOf(context);
    final monthlyExpenses = HomeProvider.monthlyExpensesOf(context);


    final dayAmount = expenseProvider.getTotalAmountByDate(currentDate);
    final monthlyAmount = expenseProvider.getTotalAmountByMonth(currentDate);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: theme.colorScheme.primaryContainer,
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                left: false,
                right: false,
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, User!',
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
                                  '$monthlyAmount',
                                  style: theme.textTheme.titleLarge,
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
                                  '$dayAmount',
                                  style: theme.textTheme.titleLarge,
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
            ),
            ListTile(
              title: const Text('Recent Expenses'),
              subtitle: const Text('Showing 5 recent expenses'),
              trailing: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AllExpensePage()));
                },
                child: const Text('View all'),
              ),
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...monthlyExpenses.map(
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
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpensePage()));
          // if (context.mounted) HomePageController.of(context).init();
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add expense'),
      ),
    );
  }
}
