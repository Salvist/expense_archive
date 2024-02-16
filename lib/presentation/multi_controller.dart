import 'package:flutter/material.dart';

class MultiController extends StatefulWidget {
  final List<ValueNotifier> controllers;
  final Widget Function(BuildContext context, List<ValueNotifier>) builder;

  const MultiController({
    super.key,
    required this.controllers,
    required this.builder,
  });

  @override
  State<MultiController> createState() => _MultiControllerState();
}

class _MultiControllerState extends State<MultiController> {
  @override
  void dispose() {
    widget.controllers.forEach(_dispose);
    super.dispose();
  }

  void _dispose(ValueNotifier n) {
    n.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
