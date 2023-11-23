import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/providers/expense_category_provider.dart';
import 'package:simple_expense_tracker/screens/add_expense_category_page.dart';
import 'package:simple_expense_tracker/utils/available_icons.dart';

class ExpenseCategoryPage extends StatelessWidget {
  const ExpenseCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ExpenseCategories.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Categories'),
            Text(
              'Swipe to show actions',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpenseCategoryPage()));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          Icon? icon;
          if (category.iconName != null) {
            icon = Icon(categoryIcons[category.iconName]);
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
