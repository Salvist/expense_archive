import 'package:simple_expense_tracker/domain/models/amount.dart';

class Business {
  final String id;
  final String name;
  final String categoryName;
  final Amount? amountPreset;

  const Business({
    this.id = '',
    required this.name,
    required this.categoryName,
    this.amountPreset,
  });

  Business copyWith({
    String? id,
    String? name,
    Amount? amountPreset,
  }) {
    return Business(
      id: id ?? this.id,
      categoryName: categoryName,
      name: name ?? this.name,
      amountPreset: amountPreset ?? this.amountPreset,
    );
  }

  @override
  String toString() => 'Business(name: $name, categoryName: $categoryName)';

  @override
  bool operator ==(covariant Business other) =>
      id == other.id && name == other.name && categoryName == other.categoryName;

  @override
  int get hashCode => Object.hash(id, name, categoryName);

  static const defaultBusinesses = <Business>[
    Business(name: 'McDonald\'s', categoryName: 'Food'),
    Business(name: 'KFC', categoryName: 'Food'),
    Business(name: 'Burger King', categoryName: 'Food'),
    Business(name: 'Pizza Hut', categoryName: 'Food'),
    Business(name: 'Starbucks', categoryName: 'Coffee'),
    Business(name: 'Costa Coffee', categoryName: 'Coffee'),
    Business(name: 'Dunkin\'', categoryName: 'Coffee'),
    Business(name: 'Rent / Mortgage', categoryName: 'Housing & Utilities'),
    Business(name: 'Electricity', categoryName: 'Housing & Utilities'),
    Business(name: 'Gas', categoryName: 'Housing & Utilities'),
    Business(name: 'Phone', categoryName: 'Housing & Utilities'),
    Business(name: 'Internet', categoryName: 'Housing & Utilities'),
    Business(name: 'Taxi', categoryName: 'Transportation'),
    Business(name: 'Uber', categoryName: 'Transportation'),
    Business(name: 'Lyft', categoryName: 'Transportation'),
    Business(name: 'Grab', categoryName: 'Transportation'),
    Business(name: 'Amazon', categoryName: 'Shopping'),
    Business(name: 'eBay', categoryName: 'Shopping'),
    Business(name: 'Alibaba', categoryName: 'Shopping'),
    Business(name: 'Walmart', categoryName: 'Shopping'),
    Business(name: 'Netflix', categoryName: 'Entertainment'),
    Business(name: 'Disney+', categoryName: 'Entertainment'),
    Business(name: 'Discovery+', categoryName: 'Entertainment'),
    Business(name: 'Steam', categoryName: 'Entertainment'),
    Business(name: 'Epic Games Store', categoryName: 'Entertainment'),
    Business(name: 'Nintendo', categoryName: 'Entertainment'),
    Business(name: 'PlayStation', categoryName: 'Entertainment'),
  ];
}
