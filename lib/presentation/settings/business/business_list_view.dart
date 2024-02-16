import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/presentation/settings/business/business_controller.dart';
import 'package:simple_expense_tracker/widgets/dialogs/edit_bussiness_dialog.dart';

class BusinessListView extends StatelessWidget {
  final ExpenseCategory? category;
  final BusinessController controller;

  const BusinessListView({
    super.key,
    required this.controller,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, allBusiness, child) {
        final businesses = allBusiness.where((b) => b.categoryName == category!.name).toList(growable: false);
        return ListView.builder(
          itemCount: businesses.length,
          itemBuilder: (context, index) {
            final business = businesses[index];
            return ListTile(
              onTap: () async {
                final editedBusiness = await showDialog<Business>(
                  context: context,
                  builder: (context) => EditBusinessDialog(business: business),
                );
                if (editedBusiness == null) return;
                controller.editBusiness(editedBusiness);
              },
              title: Text(business.name),
              subtitle: business.amountPreset != null ? Text('${business.amountPreset!}') : null,
              trailing: IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () {
                  controller.remove(business);
                },
              ),
              // trailing: business.amountPreset != null ? Text('${business.amountPreset!}') : null,
            );
          },
        );
      },
    );
  }
}
