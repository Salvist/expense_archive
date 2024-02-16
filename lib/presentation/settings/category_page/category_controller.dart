import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/expense_category_repository.dart';

class CategoryController extends ValueNotifier<List<ExpenseCategory>> {
  final ExpenseCategoryRepository _categoryRepository;
  CategoryController(this._categoryRepository) : super(const <ExpenseCategory>[]) {
    loadCategory();
  }

  ExpenseCategory? recentlyAdded;

  void loadCategory() async {
    value = await _categoryRepository.getAll();
  }

  void addCategory(ExpenseCategory category) async {
    await _categoryRepository.add(category);
    recentlyAdded = category;
    loadCategory();
  }

  void removeCategory(ExpenseCategory category) async {
    await _categoryRepository.remove(category);
    loadCategory();
  }

  @override
  void dispose() {
    print('disposed');
    super.dispose();
  }
}
