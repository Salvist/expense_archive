import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_archive/domain/models/expense.dart';
import 'package:money_archive/domain/models/expense_category.dart';
import 'package:money_archive/providers/expense_category_provider.dart';
import 'package:money_archive/providers/expenses_provider.dart';
import 'package:money_archive/screens/add_expense_category_page.dart';
import 'package:money_archive/widgets/date_picker.dart';
import 'package:money_archive/widgets/expense_category_dropdown.dart';
import 'package:money_archive/widgets/time_picker.dart';

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

  final _name = TextEditingController();
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
      name: _name.text,
      cost: double.parse(_cost.text),
      note: note,
      paidAt: DateTime.now(),
    );

    ExpenseProvider.of(context).addExpense(expense);
    Navigator.pop(context);
    // context.pop();
  }

  @override
  void didChangeDependencies() {
    categories = ExpenseCategories.of(context);
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
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          icon: const Icon(Icons.add_rounded),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddExpenseCategoryPage()),
                            );
                            // context.push('/settings/add_expense_category');
                          },
                          tooltip: 'Add new category',
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'Business / Individual',
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter a business / individual name' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cost,
                      decoration: const InputDecoration(
                        label: Text('Expense'),
                        prefixIcon: Icon(Icons.attach_money_rounded),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      validator: (value) => value!.isEmpty ? 'How much did you spend?' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _note,
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
          SizedBox(
            width: double.infinity,
            height: Theme.of(context).buttonTheme.height,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: onSubmit,
              child: const Text('Add expense'),
            ),
          ),
        ],
      ),
    );
  }
}
