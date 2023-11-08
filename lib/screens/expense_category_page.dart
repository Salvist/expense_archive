import 'package:flutter/material.dart';
import 'package:money_archive/providers/expense_category_provider.dart';
import 'package:money_archive/screens/add_expense_page.dart';

class ExpenseCategoryPage extends StatelessWidget {
  const ExpenseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ExpenseCategories.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpensePage()));
              // context.push('/settings/add_expense_category');
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          Icon? icon;
          if (category.iconCodePoint != null) {
            icon = Icon(IconData(category.iconCodePoint!, fontFamily: 'MaterialIcons'));
          }
          return ListTile(
            leading: icon,
            title: Text(category.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () {
                ExpenseCategoryProvider.of(context).removeCategory(category);
              },
            ),
          );
        },
      ),
    );
  }
}
