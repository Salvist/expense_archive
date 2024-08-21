import 'package:flutter/widgets.dart' show IconData;
import 'package:simple_expense_tracker/utils/available_icons.dart';

class ExpenseCategory {
  final String name;

  /// Please check [categoryIcons]
  final String? iconName;

  const ExpenseCategory({
    required this.name,
    this.iconName,
  });

  ExpenseCategory copyWith() {
    return ExpenseCategory(
      name: name,
      iconName: iconName,
    );
  }

  IconData? get icon => categoryIcons[iconName];

  @override
  bool operator ==(covariant ExpenseCategory other) => name == other.name && iconName == other.iconName;

  @override
  int get hashCode => Object.hash(name, iconName);

  static const defaultCategories = <ExpenseCategory>[
    ExpenseCategory(name: 'Food', iconName: 'fastfood'),
    ExpenseCategory(name: 'Coffee', iconName: 'coffee'),
    ExpenseCategory(name: 'Entertainment', iconName: 'chair'),
    ExpenseCategory(name: 'Transportation', iconName: 'subway'),
    ExpenseCategory(name: 'Housing & Utilities', iconName: 'apartment'),
    ExpenseCategory(name: 'Shopping', iconName: 'shopping_cart'),
    ExpenseCategory(name: 'Clothing', iconName: 'checkroom'),
    ExpenseCategory(name: 'Other', iconName: 'question_mark'),
  ];
}

class DuplicateCategoryException implements Exception {
  final String name;
  const DuplicateCategoryException(this.name);

  String get message => 'Category "$name" already exist.';

  @override
  String toString() => 'DuplicateCategoryException: $message';
}
