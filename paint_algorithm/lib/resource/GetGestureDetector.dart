import 'package:flutter/material.dart';

class GetGestureMouse extends StatefulWidget {
  final Function(List<Offset>) attPoints;

  const GetGestureMouse({super.key, required this.attPoints});

  @override
  State<GetGestureMouse> createState() => _GetGestureMouseState();
}

class _GetGestureMouseState extends State<GetGestureMouse> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          points.clear();
          points.add(details.localPosition);
          widget.attPoints(points);
        });
      },
      onPanUpdate: (details) {
        setState(() {
          points.clear();
          points.add(details.localPosition);
          widget.attPoints(points);
        });
      },
      onTapDown: (details) {
        points.clear();
        points.add(details.localPosition);
        widget.attPoints(points);
      },
    );
  }
}
