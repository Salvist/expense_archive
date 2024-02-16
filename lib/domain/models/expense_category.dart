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

  static const defaultCategories = <ExpenseCategory>[
    ExpenseCategory(
      name: 'Food',
      iconName: 'fastfood',
    ),
    ExpenseCategory(
      name: 'Transportation',
      iconName: 'subway',
    ),
    ExpenseCategory(
      name: 'Clothes',
      iconName: 'checkroom',
    ),
    ExpenseCategory(
      name: 'Other',
      iconName: 'question_mark',
    ),
  ];

  @override
  bool operator ==(covariant ExpenseCategory other) => name == other.name && iconName == other.iconName;

  @override
  int get hashCode => Object.hash(name, iconName);
}

class DuplicateCategoryException implements Exception {
  final String name;
  const DuplicateCategoryException(this.name);

  String get message => 'Category "$name" already exist.';

  @override
  String toString() => 'DuplicateCategoryException: $message';
}
