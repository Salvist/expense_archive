import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String titleText;
  final String? subtitleText;
  const AppBarTitle({
    super.key,
    required this.titleText,
    this.subtitleText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (subtitleText == null) {
      return Text(titleText, style: theme.appBarTheme.titleTextStyle);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleText, style: theme.appBarTheme.titleTextStyle),
        Text(subtitleText!, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
