import 'package:flutter/material.dart';
import "dart:ui";

// Imports
// import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";
import '../resource/GetGestureDetector.dart';

// Classe
import '../class/DrawingObject.dart';

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
  List<DrawingObject> drawing_object = [];
  final double width = 300;
  final double height = 300.5;
  int pixel_id = 0;

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
              updatePixelId: (p0) {
                setState(() {
                  pixel_id = p0;
                });
              },
              pixel_id: pixel_id,
              drawing_object: drawing_object,
              width: width,
              height: height,
              mode_text: widget.mode_text,
              updatePoints: (updatedPoints) {
                DrawingObject newObject = new DrawingObject();
                newObject.setOffset(updatedPoints);
                newObject.setPixelId(pixel_id);
                drawing_object.add(newObject);
              },
            ),
          ),
        )),
        VerticalBarScreen(
          drawing_object: drawing_object,
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
  final List<DrawingObject> drawing_object;
  final double width;
  final double height;
  final Function(Offset) updatePoints;
  final Function(int) updatePixelId;
  final int pixel_id;

  final String mode_text;

  CanvaWidget({
    super.key,
    required this.pixel_id,
    required this.updatePixelId,
    required this.drawing_object,
    required this.width,
    required this.height,
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
          painter: Canva(widget.drawing_object),
          child: GetGestureMouse(
            drawing_object: widget.drawing_object,
            updatePixelID_gesture_detector: (p0) {
              widget.updatePixelId(p0);
              "".toString();
            },
            pixel_id: widget.pixel_id,
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
  List<DrawingObject> drawing_object = [];

  Canva(this.drawing_object);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 1.0;

    // Paint backgroundPaint = Paint()..color = Color.fromARGB(127, 243, 240, 211);
    Paint backgroundPaint = Paint()..color = Color.fromARGB(240, 255, 255, 255);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    drawing_object.forEach((point) {
      canvas.drawPoints(PointMode.points, [point.ponto], paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
