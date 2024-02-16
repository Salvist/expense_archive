import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/repositories/repository_provider.dart';
import 'package:simple_expense_tracker/presentation/analytics/weekly_expenses_chart.dart';
import 'package:simple_expense_tracker/presentation/analytics/weekly_expenses_provider.dart';
import 'package:simple_expense_tracker/widgets/monthly_expenses/monthly_expenses_provider.dart';
import 'package:simple_expense_tracker/widgets/monthly_expenses/monthly_expenses_view.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeeklyExpensesController(
                expenseRepository: RepositoryProvider.expenseOf(context),
                builder: (controller) {
                  return WeeklyExpensesChartView(
                    controller: controller,
                  );
                },
              ),
              const SizedBox(height: 24),
              MonthlyExpensesController(
                expenseRepository: RepositoryProvider.expenseOf(context),
                categoryRepository: RepositoryProvider.categoryOf(context),
                builder: (controller) => MonthlyExpensesView(controller),
              ),
              // const CategoryExpenseListView(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
