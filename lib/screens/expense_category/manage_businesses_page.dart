import 'package:flutter/material.dart';
// import 'package:simple_expense_tracker/app/providers/business_provider.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/repository_provider.dart';
import 'package:simple_expense_tracker/presentation/settings/business/business_controller.dart';
import 'package:simple_expense_tracker/presentation/settings/business/business_list_view.dart';
import 'package:simple_expense_tracker/widgets/app_bar_title.dart';
import 'package:simple_expense_tracker/widgets/dialogs/add_business_dialog.dart';
import 'package:simple_expense_tracker/widgets/dialogs/edit_bussiness_dialog.dart';

class ManageBusinessesPage extends StatefulWidget {
  final ExpenseCategory? category;
  const ManageBusinessesPage({
    super.key,
    this.category,
  });

  static PageRoute route([ExpenseCategory? category]) {
    return MaterialPageRoute(builder: (context) => ManageBusinessesPage(category: category));
  }

  @override
  State<ManageBusinessesPage> createState() => _ManageBusinessesPageState();
}

class _ManageBusinessesPageState extends State<ManageBusinessesPage> {
  final _categories = <ExpenseCategory>[];
  late BusinessController _controller;

  int _categoryIndex = 0;

  bool _isLoadingCategory = true;

  @override
  void initState() {
    // Get all categories
    RepositoryProvider.categoryOf(context).getAll().then((value) {
      setState(() {
        _categories.clear();
        _categories.addAll(value);
        _isLoadingCategory = false;
      });
    });

    _controller = BusinessController(RepositoryProvider.businessOf(context));
    _controller.loadAll();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingCategory) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Businesses / Individuals'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return DefaultTabController(
      initialIndex: _categoryIndex,
      length: _categories.length,
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
              for (final category in _categories)
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
            for (final category in _categories)
              BusinessListView(
                category: category,
                controller: _controller,
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final business = await showAdaptiveDialog<Business>(
              context: context,
              builder: (context) {
                return AddBusinessDialog(category: _categories[_categoryIndex]);
              },
            );
            if (!mounted || business == null) return;
            _controller.addBusiness(business);
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
