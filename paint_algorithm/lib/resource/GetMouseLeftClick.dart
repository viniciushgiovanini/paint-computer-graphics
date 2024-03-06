import 'package:flutter/material.dart';

class MouseClickCoordinatesWidget extends StatelessWidget {
  final void Function(Offset) onClick;

  MouseClickCoordinatesWidget({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);
          onClick(localPosition);
        },
      ),
    );
  }
}
