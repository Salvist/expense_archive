import 'package:flutter/material.dart';

class DropdownChip<T extends Object> extends StatelessWidget {
  final T value;
  final List<T> options;
  final String Function(T option) displayOption;
  final void Function(T newValue) onChanged;

  const DropdownChip({
    super.key,
    required this.value,
    required this.options,
    this.displayOption = _displayOption,
    required this.onChanged,
  });

  static String _displayOption(Object option) => option.toString();
  // static const _defaultDisplayOption = (T option) => option.toString();

  static const _borderRadius = BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final menuChildren = options.map((option) {
      return MenuItemButton(
        onPressed: () => onChanged(option),
        child: Text(displayOption(option)),
      );
    }).toList();

    return MenuAnchor(
      menuChildren: menuChildren,
      style: MenuStyle(
        maximumSize: MaterialStatePropertyAll(Size(double.infinity, 200)),
      ),
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
                  Text(displayOption(value)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_drop_down_rounded, size: 18),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
