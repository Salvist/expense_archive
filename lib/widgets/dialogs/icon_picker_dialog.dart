import 'package:flutter/material.dart';
import 'package:money_archive/utils/available_icons.dart';

/// Return an icon name
Future<String?> showIconPicker(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) => const IconPickerDialog(),
  );
}

class IconPickerDialog extends StatelessWidget {
  const IconPickerDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select an icon'),
          Text('Swipe for more icons', style: Theme.of(context).textTheme.bodySmall)
        ],
      ),
      content: SizedBox(
        width: 400,
        height: 240,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: categoryIcons.length,
          itemBuilder: (context, index) {
            final icon = categoryIcons.entries.elementAt(index);
            // final icon = categoryIcons.values.elementAt(index);
            return IconButton(
              onPressed: () {
                Navigator.pop(context, icon.key);
              },
              icon: Icon(categoryIcons[icon.key]),
            );
          },
        ),
      ),
    );
  }
}
