import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/app/providers/expense_category_provider.dart';
import 'package:simple_expense_tracker/app/providers/expense_provider.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/screens/expense_category/add_expense_category_page.dart';
import 'package:simple_expense_tracker/widgets/expanded_button.dart';
import 'package:simple_expense_tracker/widgets/expense_category_dropdown.dart';
import 'package:simple_expense_tracker/widgets/fields/business_field.dart';
import 'package:simple_expense_tracker/widgets/fields/cost_field.dart';
import 'package:simple_expense_tracker/widgets/fields/date_picker.dart';
import 'package:simple_expense_tracker/widgets/fields/time_picker.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  late List<ExpenseCategory> categories;

  final _formKey = GlobalKey<FormState>();
  ExpenseCategory? expenseCategory;
  String? categoryErrorMessage;

  Business? _business;

  bool get enableAutocomplete => expenseCategory != null;

  final _cost = TextEditingController();
  final _note = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  bool validateExpense() {
    if (expenseCategory == null) {
      setState(() {
        categoryErrorMessage = 'Select a category';
      });
      return false;
    }
    return _formKey.currentState!.validate();
  }

  void onSubmit() {
    if (!validateExpense()) return;

    final note = _note.text.isEmpty ? null : _note.text;
    final expense = Expense(
      category: expenseCategory!,
      name: _business!.name,
      amount: Amount.fromString(_cost.text)!,
      note: note,
      paidAt: _date.copyWith(hour: _time.hour, minute: _time.minute),
    );

    ExpenseProvider.of(context).addExpense(expense);

    // ExpenseProvider.of(context).addExpense(expense);
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    categories = CategoryProvider.of(context).data;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add an expense'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpenseCategoryDropdown(
                          width: MediaQuery.of(context).size.width - 96,
                          errorText: categoryErrorMessage,
                          selectedCategory: expenseCategory,
                          onChanged: (category) {
                            setState(() {
                              expenseCategory = category;
                              _business = null;
                              _cost.text = '';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          icon: const Icon(Icons.add_rounded),
                          onPressed: () async {
                            final addedCategory = await Navigator.push<ExpenseCategory?>(
                              context,
                              MaterialPageRoute(builder: (context) => const AddExpenseCategoryPage()),
                            );
                            if (addedCategory == null) return;
                            setState(() {
                              expenseCategory = addedCategory;
                            });
                          },
                          tooltip: 'Add new category',
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BusinessField(
                      category: expenseCategory,
                      value: _business,
                      onSelected: (value) {
                        setState(() {
                          _business = value;
                        });
                        if (_business?.costPreset != null) {
                          _cost.text = _business!.costPreset!.withoutCurrency();
                        }
                      },
                      validator: (_) => _business == null ? 'Add or choose a business / individual.' : null,
                    ),
                    const SizedBox(height: 16),
                    CostField(
                      controller: _cost,
                      labelText: 'Expense',
                      validator: (value) => value!.isEmpty ? 'How much did you spend?' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _note,
                      onTapOutside: (event) {
                        // FocusScope.of(context).unfocus();
                      },
                      decoration: const InputDecoration(
                        label: Text('Note (Optional)'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DatePicker(
                            selectedDate: _date,
                            onSelectedDate: (date) {
                              if (date == null) return;
                              setState(() {
                                _date = date;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TimePicker(
                            selectedTime: _time,
                            onChanged: (time) {
                              if (time == null) return;
                              setState(() {
                                _time = time;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
          ExpandedButton(
            onPressed: onSubmit,
            child: const Text('Add expense'),
          ),
        ],
      ),
    );
  }
}
