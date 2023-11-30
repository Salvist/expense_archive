import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/expenses_provider.dart';
import 'package:simple_expense_tracker/screens/expense/all_expense_page.dart';
import 'package:simple_expense_tracker/screens/expense_category/expense_category_page.dart';
import 'package:simple_expense_tracker/screens/expense_category/manage_businesses_page.dart';
import 'package:simple_expense_tracker/widgets/dialogs/remove_all_expenses_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseCategoryPage()));
              // context.push('/settings/expense_category');
            },
            leading: const Icon(Icons.category_rounded),
            title: const Text('Manage expense categories'),
            subtitle: const Text('Add or delete category'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageBusinessesPage()));
            },
            title: const Text('Manage businesses / individuals'),
            leading: const Icon(Icons.storefront_rounded),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllExpensePage()));
              // context.push('/home/all_expenses');
            },
            leading: const Icon(Icons.payments_rounded),
            title: const Text('View all expenses'),
          ),
          ListTile(
            onTap: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) => RemoveAllExpensesDialog(
                  onDelete: () {
                    ExpenseProvider.of(context).removeAllExpense();
                  },
                ),
              );
            },
            leading: const Icon(Icons.delete_forever_rounded),
            title: const Text('Delete all expense'),
          ),
        ],
      ),
    );
  }
}
