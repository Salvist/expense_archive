import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/providers/business_provider.dart';
import 'package:simple_expense_tracker/providers/expense_category_provider.dart';
import 'package:simple_expense_tracker/widgets/app_bar_title.dart';
import 'package:simple_expense_tracker/widgets/dialogs/add_business_dialog.dart';
import 'package:simple_expense_tracker/widgets/dialogs/edit_bussiness_dialog.dart';
import 'package:simple_expense_tracker/widgets/fields/cost_field.dart';

class ManageBusinessesPage extends StatefulWidget {
  const ManageBusinessesPage({super.key});

  @override
  State<ManageBusinessesPage> createState() => _ManageBusinessesPageState();
}

class _ManageBusinessesPageState extends State<ManageBusinessesPage> {
  int _categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = ExpenseCategories.of(context);
    final businesses = Businesses.of(context);

    return DefaultTabController(
      initialIndex: _categoryIndex,
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(
            titleText: 'Businesses / Individuals',
            subtitleText: 'Tap to edit',
          ),
          bottom: TabBar(
            isScrollable: true,
            onTap: (value) => _categoryIndex = value,
            tabs: <Tab>[
              for (final category in categories)
                Tab(
                  text: category.name,
                  icon: Icon(category.icon),
                ),
            ],
          ),
          actions: [
            MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () {},
                  child: const Text('Add category'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  child: const Text('Add business / individual'),
                ),
              ],
              builder: (context, controller, child) {
                return IconButton(
                  onPressed: () {
                    controller.isOpen ? controller.close() : controller.open();
                  },
                  icon: const Icon(Icons.more_vert_rounded),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            for (final category in categories)
              ListView.builder(
                itemCount: businesses.byCategory(category).length,
                itemBuilder: (context, index) {
                  final b = businesses.byCategory(category).elementAt(index);
                  return ListTile(
                    onTap: () async {
                      final editedBusiness = await showAdaptiveDialog<Business>(
                        context: context,
                        builder: (context) => EditBusinessDialog(
                          category: category,
                          business: b,
                        ),
                      );
                      if (editedBusiness == null) return;
                      if (!mounted) return;
                      BusinessProvider.of(context).editBusiness(b, editedBusiness);
                    },
                    title: Text(b.name),
                    trailing: b.costPreset != null ? Text('${b.costPreset!}') : null,
                  );
                },
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final business = await showAdaptiveDialog<Business>(
              context: context,
              builder: (context) {
                return AddBusinessDialog(category: categories[_categoryIndex]);
              },
            );
            if (!mounted || business == null) return;
            BusinessProvider.of(context).addBusiness(business);
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
