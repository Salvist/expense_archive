import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/domain/repositories/business_repository.dart';

class BusinessController extends ValueNotifier<List<Business>> {
  final BusinessRepository _businessRepository;
  BusinessController(this._businessRepository) : super(const <Business>[]);

  void loadAll() async {
    value = await _businessRepository.getAll();
  }

  void loadByCategory(ExpenseCategory category) async {
    value = await _businessRepository.getByCategory(category);
  }

  void addBusiness(Business business) async {
    final addedBusiness = await _businessRepository.add(business);
    final list = [...value, addedBusiness];
    list.sort((a, b) => a.name.compareTo(b.name));
    value = list;
  }

  void editBusiness(Business editedBusiness) async {
    await _businessRepository.edit(editedBusiness);
    value = await _businessRepository.getAll();
  }

  void remove(Business business) async {
    await _businessRepository.remove(business);

    final list = value.toList();
    list.remove(business);
    value = list;
  }
}
