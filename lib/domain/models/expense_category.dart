import 'package:flutter/widgets.dart' show IconData;
import 'package:simple_expense_tracker/utils/available_icons.dart';

class ExpenseCategory {
  final String name;
  final int id;

  /// Please check [categoryIcons]
  final String? iconName;

  const ExpenseCategory({
    required this.name,
    this.id = 0,
    this.iconName,
  });

  ExpenseCategory copyWith({int? id}) {
    return ExpenseCategory(
      id: id ?? this.id,
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
}

class DuplicateCategoryException implements Exception {
  final String name;
  const DuplicateCategoryException(this.name);

  String get message => 'Category "$name" already exist.';

  @override
  String toString() => 'DuplicateCategoryException: $message';
}
