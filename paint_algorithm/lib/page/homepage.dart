import 'package:flutter/material.dart';
import "dart:ui";

// Imports
import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";

// ignore: must_be_immutable
class CanvaWidget extends StatefulWidget {
  final List<Offset> points;

  CanvaWidget({super.key, required this.points});

  @override
  State<CanvaWidget> createState() => _CanvaWidgetState();
}

class _CanvaWidgetState extends State<CanvaWidget> {
  double width = 300;
  double height = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomPaint(
          size: Size(width, height),
          painter: Canva(widget.points),
          child: MouseClickCoordinatesWidget(
            onClick: (Offset offset) {
              setState(() {
                widget.points.add(offset);
              });
            },
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}

class ViewerInteractive extends StatelessWidget {
  ViewerInteractive({super.key});

  final List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(0.0),
            minScale: 0.1,
            maxScale: 60.0,
            child: Container(
              child: CanvaWidget(
                points: points,
              ),
            ),
          ),
        )),
        VerticalBarScreen(points)
      ],
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

    Paint backgroundPaint = Paint()..color = Color.fromARGB(127, 243, 240, 211);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Desenha todos os pontos na lista
    points.forEach((point) {
      print(point);
      print(point.dx.round());
      print(point.dy.round());
      canvas.drawPoints(
          PointMode.points,
          [Offset(point.dx.roundToDouble(), point.dy.roundToDouble())],
          paint); // Corrigindo aqui
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
