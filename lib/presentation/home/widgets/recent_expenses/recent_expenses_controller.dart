import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';

class RecentExpensesController extends StatefulWidget {
  final ExpenseRepository repository;
  final Widget Function(bool isLoading, List<Expense> recentExpenses) builder;

  const RecentExpensesController({
    super.key,
    required this.repository,
    required this.builder,
  });

  @override
  State<RecentExpensesController> createState() => _RecentExpensesControllerState();
}

class _RecentExpensesControllerState extends State<RecentExpensesController> {
  late final Stream<List<Expense>> watchRecentExpenses;

  @override
  void initState() {
    watchRecentExpenses = widget.repository.watchRecent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Expense>>(
      stream: watchRecentExpenses,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final expenses = snapshot.requireData;
          return widget.builder(false, expenses);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
