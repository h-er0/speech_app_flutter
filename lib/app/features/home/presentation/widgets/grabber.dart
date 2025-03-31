import 'package:flutter/material.dart';

class Grabber extends StatelessWidget {
  const Grabber({super.key, required this.onVerticalDragUpdate, this.child});

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      child:
          child ??
          Container(
            width: double.infinity,
            color: colorScheme.onSurface,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                width: 32.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
    );
  }
}
