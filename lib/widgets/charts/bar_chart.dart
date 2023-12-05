import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartData {
  final String label;
  final double value;

  const ChartData({
    required this.label,
    required this.value,
  });
}

class BarChart extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;

  final List<ChartData> dataSource;

  final double width;
  final double height;
  final EdgeInsets contentPadding;

  const BarChart({
    super.key,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.trailing,
    required this.dataSource,
    this.width = 400.0,
    this.height = 240.0,
    this.contentPadding = const EdgeInsets.all(16),
  });

  static const chartNameHeight = 40.0;
  static const nameAndBarGap = 16.0;
  static const labelHeight = 20.0;

  double get maxBarHeight =>
      height - nameAndBarGap - contentPadding.vertical - 4.0 - chartNameHeight - labelHeight - Bar.minimumHeight;

  double getBarHeight(double value) {
    return value * (maxBarHeight / highestMilestone) + Bar.minimumHeight;
  }

  double get maxValue {
    final x = dataSource.reduce((value, element) => value.value > element.value ? value : element).value;
    return x;
  }

  double get highestMilestone {
    final values = dataSource.map((e) => e.value);
    final highestValue = values.reduce((value, element) => value > element ? value : element);

    if (highestValue < 1000) {
      if (highestValue % 100 == 0) return highestValue;
      return (highestValue ~/ 100) * 100 + 100;
    }
    return highestValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      width: width,
      height: height,
      padding: contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: chartNameHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) Text(title!, style: titleStyle ?? textTheme.bodyLarge),
                    if (subtitle != null) Text(subtitle!, style: subtitleStyle ?? textTheme.bodySmall),
                  ],
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          const SizedBox(height: nameAndBarGap),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: Milestones(
                    highestValue: highestMilestone,
                    numOfMilestone: 4,
                  ),
                ),
                Positioned(
                  left: 32,
                  top: 4,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final data in dataSource)
                        Bar(
                          height: getBarHeight(data.value),
                          label: Text(data.label),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final Color? color;
  final double height;
  final Widget? label;

  const Bar({
    super.key,
    required this.height,
    this.color,
    this.label,
  });

  static const minimumHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final barHeight = height > minimumHeight ? height : minimumHeight;
    final bar = Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: color ?? colorScheme.primary,
      ),
      width: 8,
      height: barHeight,
    );

    if (label == null) return bar;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        height.isInfinite ? Expanded(child: bar) : bar,
        label!,
      ],
    );
  }
}

class Milestones extends StatelessWidget {
  final double highestValue;
  final int numOfMilestone;

  const Milestones({
    super.key,
    required this.highestValue,
    this.numOfMilestone = 2,
  }) : assert(numOfMilestone >= 2);

  double get lowestCycle {
    return highestValue / (numOfMilestone - 1);
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.compactSimpleCurrency(decimalDigits: 0);
    final textTheme = Theme.of(context).textTheme;

    // final lowestCycle = highestValue / (numOfMilestone - 1);
    final x = [for (int i = 0; i < numOfMilestone; i++) lowestCycle * i];

    final re = x.reversed;

    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final value in re) Text(formatter.format(value), style: textTheme.bodySmall),
            // Text(formatter.format(highestValue), style: textTheme.bodySmall),
            // Text(formatter.format(75.0), style: textTheme.bodySmall),
            // Text('\$0', style: textTheme.bodySmall),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [for (int i = 0; i < numOfMilestone; i++) const Divider()],
          ),
        )
      ],
    );
  }
}
