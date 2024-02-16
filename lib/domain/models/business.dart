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
}
