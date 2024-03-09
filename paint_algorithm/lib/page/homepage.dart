import 'package:flutter/material.dart';
import "dart:ui";

// Imports
// import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";
import '../resource/GetGestureDetector.dart';

// ###########################
// Classe do ViewerInteractive
// ###########################
// ignore: must_be_immutable
class ViewerInteractive extends StatefulWidget {
  String mode_text;
  void Function(String) updateStringMode;

  ViewerInteractive(
      {super.key, required this.mode_text, required this.updateStringMode});

  @override
  State<ViewerInteractive> createState() => _ViewerInteractiveState();
}

class _ViewerInteractiveState extends State<ViewerInteractive> {
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
            boundaryMargin: const EdgeInsets.all(0.0),
            minScale: 0.1,
            maxScale: 60.0,
            child: CanvaWidget(
              points: points,
              width: width,
              height: height,
              mode_text: widget.mode_text,
              updatePoints: (updatedPoints) {
                points.addAll(updatedPoints);
              },
            ),
          ),
        )),
        VerticalBarScreen(
          points: points,
          updateMode: (txt_mode) {
            setState(() {
              widget.updateStringMode(txt_mode);
            });
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CanvaWidget extends StatefulWidget {
  final List<Offset> points;
  final double width;
  final double height;
  final Function(List<Offset>) updatePoints;

  final String mode_text;

  CanvaWidget({
    super.key,
    required this.width,
    required this.height,
    required this.points,
    required this.updatePoints,
    required this.mode_text,
  });

  @override
  State<CanvaWidget> createState() => _CanvaWidgetState();
}

// #####################
// Classe do Canva
// #####################
class _CanvaWidgetState extends State<CanvaWidget> {
  bool rodou_alg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: Canva(widget.points),
          child: GetGestureMouse(
            points: widget.points,
            rodou_alg: rodou_alg,
            mode_text: widget.mode_text,
            attPoints: (pontos_att) {
              setState(() {
                widget.updatePoints(pontos_att);
              });
            },
            updateRodouAlg: (details) {
              setState(() {
                rodou_alg = details;
              });
            },
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
      canvas.drawPoints(PointMode.points, [point], paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
