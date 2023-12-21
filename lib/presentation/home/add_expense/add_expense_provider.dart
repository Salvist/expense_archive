// import 'dart:collection';
//
// import 'package:flutter/material.dart';
// import 'package:simple_expense_tracker/domain/models/business.dart';
// import 'package:simple_expense_tracker/domain/models/expense_category.dart';
// import 'package:simple_expense_tracker/domain/repositories/expense_repository.dart';
//
// class AddExpenseProvider extends InheritedWidget {
//   final UnmodifiableListView<ExpenseCategory> categories;
//   final UnmodifiableListView<Business> businesses;
//
//   const AddExpenseProvider({
//     super.key,
//     required this.categories,
//     required this.businesses,
//     required super.child,
//   });
//
//   static AddExpenseProvider of(BuildContext context) {
//     final AddExpenseProvider? result = context.dependOnInheritedWidgetOfExactType<AddExpenseProvider>();
//     assert(result != null, 'No AddExpenseProvider found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(AddExpenseProvider old) {
//     return true;
//   }
// }
//
// class AddExpenseController extends StatefulWidget {
//   final ExpenseRepository expenseRepository;
//   final Widget child;
//   const AddExpenseController({
//     super.key,
//     required this.expenseRepository,
//     required this.child,
//   });
//
//   @override
//   State<AddExpenseController> createState() => _AddExpenseControllerState();
// }
//
// class _AddExpenseControllerState extends State<AddExpenseController> {
//   var categories = <ExpenseCategory>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return AddExpenseProvider(
//       categories: UnmodifiableListView(categories),
//       child: widget.child,
//     );
//   }
// }
