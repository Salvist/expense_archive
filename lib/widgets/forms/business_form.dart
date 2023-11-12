import 'package:flutter/material.dart';
import 'package:money_archive/widgets/fields/cost_field.dart';

class BusinessForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController amountController;

  const BusinessForm({
    super.key,
    required this.nameController,
    required this.amountController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Business / Individual',
            ),
          ),
          const SizedBox(height: 16),
          CostField(controller: amountController),
        ],
      ),
    );
  }
}
