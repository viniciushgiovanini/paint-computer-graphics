import 'package:flutter/material.dart';

class MouseClickCoordinatesWidget extends StatelessWidget {
  final void Function(Offset) onClick;

  double width;
  double height;

  MouseClickCoordinatesWidget(
      {required this.onClick, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: this.height,
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
