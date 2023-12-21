import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/expense_provider.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/presentation/home/home_provider.dart';
import 'package:simple_expense_tracker/presentation/home/widgets/monthly_amount_view.dart';
import 'package:simple_expense_tracker/presentation/home/widgets/recent_expenses_list_view.dart';
import 'package:simple_expense_tracker/presentation/home/widgets/today_amount_view.dart';
import 'package:simple_expense_tracker/presentation/home/add_expense/add_expense_page.dart';
import 'package:simple_expense_tracker/presentation/home/all_expense_page.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';
import 'package:simple_expense_tracker/widgets/dialogs/expense_info_dialog.dart';
import 'package:simple_expense_tracker/widgets/expense_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                          const Expanded(
                            child: MonthlyAmountView(),
                          ),
                          VerticalDivider(
                            indent: 4,
                            endIndent: 4,
                            color: theme.colorScheme.primary,
                          ),
                          const Expanded(
                            child: TodayAmountView(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const RecentExpensesListView(),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final expense = await Navigator.push<Expense>(context, AddExpensePage.route());
          if (!context.mounted || expense == null) return;
          HomePageController.of(context).addExpense(expense);
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add expense'),
      ),
    );
  }
}
