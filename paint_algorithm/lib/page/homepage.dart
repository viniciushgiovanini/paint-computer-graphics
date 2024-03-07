import 'package:flutter/material.dart';
import "dart:ui";

// Imports
import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";

class CanvaWidget extends StatefulWidget {
  const CanvaWidget({super.key});

  @override
  State<CanvaWidget> createState() => _CanvaWidgetState();
}

class _CanvaWidgetState extends State<CanvaWidget> {
  List<Offset> points = [];

  double width = 300;
  double height = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            child: CustomPaint(
              size: Size(width, height),
              painter: Canva(points),
              child: MouseClickCoordinatesWidget(
                onClick: (Offset offset) {
                  setState(() {
                    points.add(offset);
                  });
                },
                width: width,
                height: height,
              ),
            ),
          )),
          VerticalBarScreen(points)
        ],
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
      ..strokeWidth = 10.0;

    Paint backgroundPaint = Paint()..color = Color.fromARGB(127, 243, 240, 211);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Desenha todos os pontos na lista
    points.forEach((point) {
      canvas.drawPoints(PointMode.points, [point], paint); // Corrigindo aqui
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
