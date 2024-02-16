import 'package:flutter/widgets.dart';

class Controller<T extends ValueNotifier<E>, E> extends StatefulWidget {
  final T Function(BuildContext context) create;
  final Widget Function(BuildContext context, T controller) builder;

  const Controller({
    super.key,
    required this.create,
    required this.builder,
  });

  @override
  State<Controller> createState() => _ControllerState<T, E>();
}

class _ControllerState<T extends ValueNotifier<E>, E> extends State<Controller<T, E>> {
  late T _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.create(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller);
}
