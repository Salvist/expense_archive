import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/providers/expense_category_provider.dart';
import 'package:simple_expense_tracker/utils/available_icons.dart';
import 'package:simple_expense_tracker/widgets/dialogs/icon_picker_dialog.dart';
import 'package:simple_expense_tracker/widgets/expanded_button.dart';
import 'package:simple_expense_tracker/widgets/fields/cost_field.dart';

class BusinessController {
  int id;
  final TextEditingController name;
  final TextEditingController amountPreset;

  BusinessController({
    this.id = 0,
  })  : name = TextEditingController(),
        amountPreset = TextEditingController();
}

class AddExpenseCategoryPage extends StatefulWidget {
  const AddExpenseCategoryPage({super.key});

  @override
  State<AddExpenseCategoryPage> createState() => _AddExpenseCategoryPageState();
}

class _AddExpenseCategoryPageState extends State<AddExpenseCategoryPage> {
  final _nameController = TextEditingController();
  String? _nameErrorMessage;

  String? _iconName;
  IconData? get selectedIcon => categoryIcons[_iconName];
  String? _iconErrorMessage;

  final businessControllers = <BusinessController>[
    BusinessController(),
  ];

  void _addCategory() async {
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameErrorMessage = 'Write category name';
      });
      return;
    }
    try {
      final category = ExpenseCategory(
        name: _nameController.text,
        iconName: _iconName,
      );

      final addedCategory = await ExpenseCategoryProvider.of(context).addCategory(category);

      // final businessNames = businessControllers.map((e) => e.name.text);
      // for(final business in businessControllers){
      //   if(business.name.text.isNotEmpty){
      //     BusinessProvider.of(context).
      //   }
      // }
      // final addedCategory = await ExpenseCategoryProvider.of(context).addCategory(
      //   name: _nameController.text,
      //   iconData: _icon?.icon?.codePoint,
      // );
      if (!mounted) return;
      Navigator.pop(context, addedCategory);
    } on DuplicateCategoryException catch (e) {
      setState(() {
        _nameErrorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add a new category'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final iconName = await showIconPicker(context);
                          setState(() {
                            _iconName = iconName;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _iconErrorMessage == null ? colorScheme.surfaceVariant : colorScheme.errorContainer,
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                          ),
                          width: 64,
                          height: 64,
                          alignment: Alignment.center,
                          child: selectedIcon != null ? Icon(selectedIcon) : const Text('No Icon'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            label: const Text('Category name'),
                            helperText: '',
                            errorText: _nameErrorMessage,
                          ),
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      )
                    ],
                  ),
                  // const SizedBox(height: 16),

                  Text('Add businesses / individuals', style: textTheme.bodyLarge),
                  Text('Optional, up to 4 at a time', style: textTheme.bodySmall),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final business in businessControllers)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      // BusinessField(
                                      //   controller: business.name,
                                      // ),
                                      const SizedBox(height: 8),
                                      CostField(
                                        controller: business.amountPreset,
                                        labelText: 'Cost preset',
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                                if (business.id > 0)
                                  IconButton(
                                    icon: const Icon(Icons.clear_rounded),
                                    onPressed: () {
                                      setState(() {
                                        businessControllers.removeAt(business.id);
                                      });
                                      for (int i = 0; i < businessControllers.length; i++) {
                                        businessControllers[i].id = i;
                                      }
                                    },
                                  ),
                              ],
                            ),
                          const SizedBox(height: 8),
                          if (businessControllers.length < 4)
                            FilledButton.tonal(
                              onPressed: () {
                                setState(() {
                                  businessControllers.add(BusinessController(id: businessControllers.length));
                                });
                              },
                              child: const Text('Add more'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ExpandedButton(
            onPressed: _addCategory,
            child: const Text('Add category'),
          ),
        ],
      ),
    );
  }
}
