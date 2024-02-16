import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/expense_provider.dart';
import 'package:simple_expense_tracker/presentation/home/all_expense_page.dart';
import 'package:simple_expense_tracker/presentation/settings/category_page/expense_category_page.dart';
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
              Navigator.push(context, ExpenseCategoryPage.route(context));
            },
            leading: const Icon(Icons.category_rounded),
            title: const Text('Manage expense categories'),
            subtitle: const Text('Add or delete category'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, ManageBusinessesPage.route());
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
                    ExpenseProvider.of(context).removeAll();
                  },
                ),
              );
            },
            leading: const Icon(Icons.delete_forever_rounded),
            title: const Text('Delete all expense'),
          ),
          ListTile(
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
