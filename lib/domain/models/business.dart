import 'package:simple_expense_tracker/domain/models/amount.dart';

class Business {
  final String name;
  final String categoryName;
  final Amount? amountPreset;

  const Business({
    required this.name,
    required this.categoryName,
    this.amountPreset,
  });

  Business copyWith({
    String? name,
    Amount? amountPreset,
  }) {
    return Business(
      categoryName: categoryName,
      name: name ?? this.name,
      amountPreset: amountPreset ?? this.amountPreset,
    );
  }
}
