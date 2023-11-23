import 'package:simple_expense_tracker/domain/models/amount.dart';

class Business {
  final String name;
  final String categoryName;
  final Amount? costPreset;

  const Business({
    required this.name,
    required this.categoryName,
    this.costPreset,
  });

  Business copyWith({
    String? name,
    Amount? costPreset,
  }) {
    return Business(
      categoryName: categoryName,
      name: name ?? this.name,
      costPreset: costPreset ?? this.costPreset,
    );
  }
}
