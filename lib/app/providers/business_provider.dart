// import 'package:flutter/material.dart';
// import 'package:simple_expense_tracker/domain/models/business.dart';
// import 'package:simple_expense_tracker/domain/models/expense_category.dart';
// import 'package:simple_expense_tracker/domain/repositories/business_repository.dart';
//
// class BusinessProvider extends InheritedWidget {
//   final List<Business> data;
//
//   const BusinessProvider({
//     super.key,
//     required this.data,
//     required Widget child,
//   }) : super(child: child);
//
//   Iterable<Business> byCategory(ExpenseCategory category) {
//     return data.where((business) => business.categoryName == category.name);
//   }
//
//   static BusinessProvider of(BuildContext context) {
//     final BusinessProvider? result = context.dependOnInheritedWidgetOfExactType<BusinessProvider>();
//     assert(result != null, 'No Businesses found in context');
//     return result!;
//   }
//
//   @override
//   bool updateShouldNotify(BusinessProvider oldWidget) {
//     return true;
//   }
// }
//
// class BusinessNotifier extends StatefulWidget {
//   final BusinessRepository repository;
//   final Widget child;
//
//   const BusinessNotifier({
//     super.key,
//     required this.repository,
//     required this.child,
//   });
//
//   static BusinessNotifierState of(BuildContext context) {
//     return context.findAncestorStateOfType<BusinessNotifierState>()!;
//   }
//
//   @override
//   State<BusinessNotifier> createState() => BusinessNotifierState();
// }
//
// class BusinessNotifierState extends State<BusinessNotifier> {
//   final _data = <Business>[];
//
//   @override
//   void initState() {
//     widget.repository.getAll().then((value) {
//       setState(() {
//         _data.clear();
//         _data.addAll(value);
//         _data.addAll(defaultBusinesses);
//       });
//     });
//
//     super.initState();
//   }
//
//   void addBusiness(Business business) {
//     widget.repository.add(business);
//     setState(() {
//       _data.add(business);
//     });
//   }
//
//   void editBusiness(Business previousBusiness, Business editedBusiness) {
//     final index = _data.indexOf(previousBusiness);
//     if (index == -1) return;
//     widget.repository.edit(editedBusiness);
//     setState(() {
//       _data[index] = editedBusiness;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BusinessProvider(
//       data: _data,
//       child: widget.child,
//     );
//   }
// }
//
// const defaultBusinesses = <Business>[
//   Business(
//     categoryName: 'Food',
//     name: 'KFC',
//   ),
//   Business(
//     categoryName: 'Food',
//     name: 'McDonalds',
//   ),
//   Business(
//     categoryName: 'Food',
//     name: 'Khao Nom',
//   ),
// ];
