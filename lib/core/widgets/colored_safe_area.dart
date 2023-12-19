import 'package:flutter/material.dart';

class ColoredSafeArea extends StatelessWidget {
  const ColoredSafeArea({
    Key? key,
    required this.child,
    required this.color,
  }) : super(key: key);
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
// ?? Theme.of(context).colorScheme.primary
