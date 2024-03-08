import 'package:flutter/material.dart';
import "dart:ui";

// Imports
import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";

// ###########################
// Classe do ViewerInteractive
// ###########################

// ignore: must_be_immutable

class ViewerInteractive extends StatelessWidget {
  ViewerInteractive({super.key});

  final List<Offset> points = [];
  final double width = 300;
  final double height = 300.5;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          height: height,
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(60.0),
            minScale: 0.1,
            maxScale: 60.0,
            child: CanvaWidget(
              points: points,
              width: width,
              height: height,
            ),
          ),
        )),
        VerticalBarScreen(points)
      ],
    );
  }
}

class CanvaWidget extends StatefulWidget {
  final List<Offset> points;
  final double width;
  final double height;

  CanvaWidget(
      {super.key,
      required this.points,
      required this.width,
      required this.height});

  @override
  State<CanvaWidget> createState() => _CanvaWidgetState();
}

// #####################
// Classe do Canva
// #####################
class _CanvaWidgetState extends State<CanvaWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: Canva(widget.points),
          child: MouseClickCoordinatesWidget(
            onClick: (Offset offset) {
              setState(() {
                widget.points.add(offset);
                print(offset);
              });
            },
            width: widget.width,
            height: widget.height,
          ),
        ),
      ),
    );
  }
}

// #####################
// Classe do Painter
// #####################

class Canva extends CustomPainter {
  List<Offset> points;

  Canva(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 1.0;

    // Paint backgroundPaint = Paint()..color = Color.fromARGB(127, 243, 240, 211);
    Paint backgroundPaint = Paint()..color = Color.fromARGB(240, 255, 255, 255);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    points.forEach((point) {
      canvas.drawPoints(PointMode.points,
          [Offset(point.dx.roundToDouble(), point.dy.roundToDouble())], paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
