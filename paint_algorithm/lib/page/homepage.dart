import 'package:flutter/material.dart';
import "dart:ui";

// Imports
// import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";
import '../resource/GetGestureDetector.dart';

// Classe
import '../class/Points.dart';
import '../class/Object.dart';

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
  List<Points> points_class = [];
  final double width = 300;
  final double height = 300.5;
  int pixel_id = 0;
  List<Object> lista_objetos = [];
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
              points_class: points_class,
              width: width,
              height: height,
              mode_text: widget.mode_text,
              updatePoints: (updatedPoints) {
                // Points newObject = new Points();
                // newObject.setOffset(updatedPoints);
                // newObject.setPixelId(pixel_id);
                points_class.addAll(updatedPoints);
              },
              lista_objetos: lista_objetos,
            ),
          ),
        )),
        VerticalBarScreen(
          points_class: points_class,
          updatePixelId: (p0) {
            setState(() {
              pixel_id = p0;
            });
          },
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
  final List<Points> points_class;
  final double width;
  final double height;
  final Function(List<Points>) updatePoints;
  final Function(int) updatePixelId;
  final int pixel_id;
  final List<Object> lista_objetos;

  final String mode_text;

  CanvaWidget({
    super.key,
    required this.lista_objetos,
    required this.pixel_id,
    required this.updatePixelId,
    required this.points_class,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: Canva(widget.points_class),
          child: GetGestureMouse(
            points_class: widget.points_class,
            updatePixelID_gesture_detector: (p0) {
              widget.updatePixelId(p0);
              "".toString();
            },
            pixel_id: widget.pixel_id,
            mode_text: widget.mode_text,
            attPoints: (pontos_att) {
              setState(() {
                widget.updatePoints(pontos_att);
              });
            },
            lista_objetos: widget.lista_objetos,
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
  List<Points> points_class = [];

  Canva(this.points_class);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 1.0;

    // Paint backgroundPaint = Paint()..color = Color.fromARGB(127, 243, 240, 211);
    Paint backgroundPaint = Paint()..color = Color.fromARGB(240, 255, 255, 255);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    points_class.forEach((point) {
      canvas.drawPoints(PointMode.points, [point.ponto], paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
