import 'package:flutter/material.dart';

class SlidingSegmentedButton extends StatefulWidget {
  const SlidingSegmentedButton({super.key});

  @override
  State<SlidingSegmentedButton> createState() => _SlidingSegmentedButtonState();
}

class _SlidingSegmentedButtonState extends State<SlidingSegmentedButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  int selected = 0;

  late List<double> positions;
  double posX = 0.0;
  bool left = true;

  double? size;
  List<GlobalKey> keys = [GlobalKey(), GlobalKey()];

  static const _duration = Duration(milliseconds: 400);

  @override
  void initState() {
    // _controller = AnimationController(vsync: this, duration: _duration);
    // _animation = Tween<double>(begin: 0.0, end: 100).animate(_controller);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final box = keys[1].currentContext?.findRenderObject() as RenderBox;
      print(box.localToGlobal(Offset.zero).dx);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        AnimatedPositioned(
          duration: _duration,
          left: left ? 0.0 : null,
          right: left ? null : 0.0,
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: colorScheme.primary,
            ),
            width: 190,
            height: 40,
          ),
        ),
        Row(
          children: [
            Expanded(
              key: keys[0],
              child: SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Weekly'),
                ),
              ),
            ),
            Expanded(
              key: keys[1],
              child: GestureDetector(
                onTap: () {
                  // if (_controller.isCompleted) {
                  //   _controller.reverse();
                  // } else {
                  //   _controller.forward();
                  // }
                  print('tap');
                  setState(() {
                    left = !left;
                  });
                },
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Monthly'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
