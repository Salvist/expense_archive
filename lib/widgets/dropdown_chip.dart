import 'package:flutter/material.dart';

class DropdownChip<T> extends StatefulWidget {
  final T value;
  final List<T> otherValues;
  final void Function(T newValue) onChanged;

  const DropdownChip({
    super.key,
    required this.value,
    required this.otherValues,
    required this.onChanged,
  });

  @override
  State<DropdownChip> createState() => _DropdownChipState();
}

class _DropdownChipState extends State<DropdownChip> {
  static const _borderRadius = BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          child: Text('January'),
        ),
      ],
      builder: (context, controller, child) {
        return Material(
          color: colorScheme.secondaryContainer,
          borderRadius: _borderRadius,
          child: InkWell(
            onTap: () {
              controller.isOpen ? controller.close() : controller.open();
            },
            borderRadius: _borderRadius,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.value),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_drop_down_rounded, size: 18),
                ],
              ),
            ),
          ),
        );
      },
      // child: Material(
      //   color: colorScheme.secondaryContainer,
      //   borderRadius: _borderRadius,
      //   child: InkWell(
      //     onTap: () {},
      //     borderRadius: _borderRadius,
      //     child: Padding(
      //       padding: const EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
      //       child: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Text('December'),
      //           const SizedBox(width: 8),
      //           const Icon(Icons.arrow_drop_down_rounded, size: 18),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
