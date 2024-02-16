import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/repository_provider.dart';
import 'package:simple_expense_tracker/presentation/controller.dart';
import 'package:simple_expense_tracker/presentation/settings/category_page/add_expense_category_page.dart';
import 'package:simple_expense_tracker/presentation/settings/category_page/category_controller.dart';
import 'package:simple_expense_tracker/presentation/settings/category_page/remove_category_dialog.dart';
import 'package:simple_expense_tracker/screens/expense_category/manage_businesses_page.dart';
import 'package:simple_expense_tracker/utils/available_icons.dart';

class ExpenseCategoryPage extends StatelessWidget {
  final CategoryController controller;
  const ExpenseCategoryPage(
    this.controller, {
    super.key,
  });

  static PageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => Controller(
        create: (context) => CategoryController(RepositoryProvider.categoryOf(context)),
        builder: (context, controller) => ExpenseCategoryPage(controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () async {
              final category = await Navigator.push<ExpenseCategory>(context, AddExpenseCategoryPage.route());
              if (category == null) return;
              controller.addCategory(category);
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, categories, child) {
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              Icon? icon;
              if (category.iconName != null) {
                icon = Icon(categoryIcons[category.iconName]);
              }

              return ListTile(
                leading: Badge(
                  isLabelVisible: controller.recentlyAdded == category,
                  label: const Text('New'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: icon,
                ),
                title: Text(category.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Remove category',
                      icon: const Icon(Icons.delete_rounded),
                      onPressed: () {
                        final sharedPrefsRepo = RepositoryProvider.sharedPrefsOf(context);
                        if (sharedPrefsRepo.askOnRemoveCategory()) {
                          showDialog(
                            context: context,
                            builder: (context) => RemoveCategoryDialog(
                              category: category,
                              onRemove: (category) {
                                controller.removeCategory(category);
                              },
                            ),
                          );
                        } else {
                          controller.removeCategory(category);
                        }
                      },
                    ),
                    IconButton(
                      tooltip: 'Add business/individual',
                      icon: const Icon(Icons.add_rounded),
                      onPressed: () {
                        Navigator.push(context, ManageBusinessesPage.route(category));
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
