import 'package:flutter/material.dart';
import 'package:money_archive/domain/models/business.dart';
import 'package:money_archive/domain/models/expense_category.dart';
import 'package:money_archive/domain/repositories/business_repository.dart';

class Businesses extends InheritedWidget {
  final List<Business> data;

  const Businesses({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);

  Iterable<Business> byCategory(ExpenseCategory category) {
    return data.where((business) => business.categoryName == category.name);
  }

  // Iterable<Iterable<Business>> byCategories(Iterable<ExpenseCategory> categories){
  //   f
  //
  // }

  static Businesses of(BuildContext context) {
    final Businesses? result = context.dependOnInheritedWidgetOfExactType<Businesses>();
    assert(result != null, 'No Businesses found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Businesses oldWidget) {
    return true;
  }
}

class BusinessProvider extends StatefulWidget {
  final BusinessRepository repository;
  final Widget child;

  const BusinessProvider({
    super.key,
    required this.repository,
    required this.child,
  });

  static BusinessProviderState of(BuildContext context) {
    return context.findAncestorStateOfType<BusinessProviderState>()!;
  }

  @override
  State<BusinessProvider> createState() => BusinessProviderState();
}

class BusinessProviderState extends State<BusinessProvider> {
  final _data = <Business>[];

  @override
  void initState() {
    widget.repository.getAll().then((value) {
      setState(() {
        _data.clear();
        _data.addAll(value);
        _data.addAll(defaultBusinesses);
      });
    });

    super.initState();
  }

  void addBusiness(Business business) {
    widget.repository.add(business);
    setState(() {
      _data.add(business);
    });
  }

  void editBusiness(Business previousBusiness, Business editedBusiness) {
    final index = _data.indexOf(previousBusiness);
    if (index == -1) return;
    widget.repository.edit(editedBusiness);
    setState(() {
      _data[index] = editedBusiness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Businesses(
      data: _data,
      child: widget.child,
    );
  }
}

const defaultBusinesses = <Business>[
  Business(
    categoryName: 'Food',
    name: 'KFC',
  ),
  Business(
    categoryName: 'Food',
    name: 'McDonalds',
  ),
  Business(
    categoryName: 'Food',
    name: 'Khao Nom',
  ),
];
