import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/presentation/home/add_expense/add_expense_page.dart';
import 'package:simple_expense_tracker/presentation/home/widgets/amount_view.dart';
import 'package:simple_expense_tracker/presentation/home/widgets/recent_expenses_list_view.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class HomePage extends StatelessWidget {
  final Stream<Amount> watchMonthlyAmount;
  final Stream<Amount> watchTodayAmount;
  final Stream<List<Expense>> watchRecentExpenses;

  const HomePage({
    super.key,
    required this.watchMonthlyAmount,
    required this.watchTodayAmount,
    required this.watchRecentExpenses,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentDate = DateTime.now();

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
                            child: WatchAmountView(
                              title: Text(DateTime.now().monthName),
                              watchAmount: watchMonthlyAmount,
                            ),
                          ),
                          VerticalDivider(
                            indent: 4,
                            endIndent: 4,
                            color: theme.colorScheme.primary,
                          ),
                          Expanded(
                            child: WatchAmountView(
                              title: const Text('Today'),
                              watchAmount: watchTodayAmount,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const RecentExpensesListView(),

            StreamBuilder<List<Expense>>(
              stream: watchRecentExpenses,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final recentExpenses = snapshot.requireData;
                  return RecentExpensesListView(
                    isLoading: false,
                    recentExpenses: recentExpenses,
                  );
                }
                return const CircularProgressIndicator();
              },
            ),

            // RecentExpensesController(
            //   repository: RepositoryProvider.expenseOf(context),
            //   builder: (isLoading, recentExpenses) => RecentExpensesListView(
            //     isLoading: isLoading,
            //     recentExpenses: recentExpenses,
            //   ),
            // ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final expense = await Navigator.push<Expense>(context, AddExpensePage.route());
          if (!context.mounted || expense == null) return;
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add expense'),
      ),
    );
  }
}
