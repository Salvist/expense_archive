import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/amount.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/repository_provider.dart';
import 'package:simple_expense_tracker/presentation/settings/category_page/add_expense_category_page.dart';
import 'package:simple_expense_tracker/widgets/expanded_button.dart';
import 'package:simple_expense_tracker/widgets/fields/business_field.dart';
import 'package:simple_expense_tracker/widgets/fields/cost_field.dart';
import 'package:simple_expense_tracker/widgets/fields/date_picker.dart';
import 'package:simple_expense_tracker/widgets/fields/expense_category_dropdown.dart';
import 'package:simple_expense_tracker/widgets/fields/time_picker.dart';

class AddExpensePage extends StatefulWidget {
  final ExpenseRepository expenseRepository;
  final ExpenseCategoryRepository categoryRepository;

  const AddExpensePage({
    super.key,
    required this.expenseRepository,
    required this.categoryRepository,
  });

  static PageRoute<Expense> route() {
    return MaterialPageRoute(builder: (context) {
      return AddExpensePage(
        expenseRepository: RepositoryProvider.expenseOf(context),
        categoryRepository: RepositoryProvider.categoryOf(context),
      );
    });
  }

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

  final _amount = TextEditingController();
  final _note = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  bool _isLoading = false;

  bool validateExpense() {
    if (expenseCategory == null) {
      setState(() {
        categoryErrorMessage = 'Select a category';
      });
      return false;
    }
    return _formKey.currentState!.validate();
  }

  void onSubmit() async {
    if (!validateExpense()) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final note = _note.text.isEmpty ? null : _note.text;
      final expense = Expense(
        category: expenseCategory!,
        name: _business!.name,
        amount: Amount.fromString(_amount.text)!,
        note: note,
        paidAt: _date.copyWith(hour: _time.hour, minute: _time.minute),
      );

      await widget.expenseRepository.add(expense);
      if (!mounted) return;
      Navigator.pop<Expense>(context, expense);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    widget.categoryRepository.getAll().then((categories) {
      setState(() {
        this.categories = categories;
      });
    });
    super.initState();
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
                      children: [
                        ExpenseCategoryDropdown(
                          categoryRepository: RepositoryProvider.categoryOf(context),
                          width: MediaQuery.of(context).size.width - 96,
                          errorText: categoryErrorMessage,
                          selectedCategory: expenseCategory,
                          onChanged: (category) {
                            setState(() {
                              expenseCategory = category;
                              _business = null;
                              _amount.text = '';
                            });
                            print(expenseCategory?.name);
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          icon: const Icon(Icons.add_rounded),
                          onPressed: () async {
                            final addedCategory = await Navigator.push<ExpenseCategory?>(
                              context,
                              AddExpenseCategoryPage.route(),
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
                        if (_business?.amountPreset != null) {
                          _amount.text = _business!.amountPreset!.withoutCurrency();
                        }
                      },
                      validator: (_) => _business == null ? 'Add or choose a business / individual.' : null,
                    ),
                    const SizedBox(height: 16),
                    AmountField(
                      controller: _amount,
                      labelText: 'Amount',
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
