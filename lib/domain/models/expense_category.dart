import 'package:flutter/widgets.dart' show IconData;
import 'package:money_archive/utils/available_icons.dart';

class ExpenseCategory {
  final String name;
  final int id;
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
}

class DuplicateCategoryException implements Exception {
  final String name;
  const DuplicateCategoryException(this.name);

  String get message => 'Category "$name" already exist.';

  @override
  String toString() => 'DuplicateCategoryException: $message';
}
