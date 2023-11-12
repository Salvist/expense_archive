import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const ExpandedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Theme.of(context).buttonTheme.height,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
