import 'package:flutter/material.dart';
import 'package:paint_algorithm/class/DrawingObject.dart';

// meus imports
import '../algorithms/dda.dart';
import '../algorithms/bresenham.dart';

// ignore: must_be_immutable
class GetGestureMouse extends StatefulWidget {
  final Function(Offset) attPoints;
  final String mode_text;
  final Function(bool) updateRodouAlg;
  final Function(int) updatePixelID_gesture_detector;
  final List<DrawingObject> drawing_object;
  int pixel_id;
  bool rodou_alg;

  GetGestureMouse({
    super.key,
    required this.drawing_object,
    required this.updatePixelID_gesture_detector,
    required this.pixel_id,
    required this.attPoints,
    required this.mode_text,
    required this.rodou_alg,
    required this.updateRodouAlg,
  });

  @override
  State<GetGestureMouse> createState() => _GetGestureMouseState();
}

class _GetGestureMouseState extends State<GetGestureMouse> {
  Offset points_unico = Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          if (widget.mode_text == "Painter") {
            DrawingObject newObject = new DrawingObject();
            if (!newObject.isList(
                widget.drawing_object,
                Offset(details.localPosition.dx.roundToDouble(),
                    details.localPosition.dy.roundToDouble()))) {
              points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                  details.localPosition.dy.roundToDouble()));
              widget.attPoints(points_unico);
            }
          }
        });
      },
      onPanUpdate: (details) {
        setState(() {
          if (widget.mode_text == "Painter") {
            DrawingObject newObject = new DrawingObject();
            if (!newObject.isList(
                widget.drawing_object,
                Offset(details.localPosition.dx.roundToDouble(),
                    details.localPosition.dy.roundToDouble()))) {
              points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                  details.localPosition.dy.roundToDouble()));
              widget.attPoints(points_unico);
            }
          }
        });
      },
      onTapDown: (details) {
        DrawingObject newObject = new DrawingObject();
        if (!newObject.isList(
            widget.drawing_object,
            Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()))) {
          points_unico = (Offset(details.localPosition.dx.roundToDouble(),
              details.localPosition.dy.roundToDouble()));
          widget.attPoints(points_unico);

          // checkDDAorBresenham(widget.mode_text, widget.points, widget.attPoints,
          //     widget.updateRodouAlg, points_unico, widget.rodou_alg);
        }
      },
      onPanEnd: (details) {
        int newID = ++widget.pixel_id;
        widget.updatePixelID_gesture_detector(newID);
      },
      onTapUp: (details) {
        int newID = ++widget.pixel_id;
        widget.updatePixelID_gesture_detector(newID);
      },
    );
  }
}

// #################
// Funcoes de Check
// #################

void checkDDAorBresenham(
    String mode_text,
    List<Offset> points,
    Function(List<Offset>) attPoints,
    Function(bool) updateRodouAlg,
    List<Offset> points_unico,
    bool rodou_alg) {
  if ((mode_text == "DDA" || mode_text == "Bresenham-Reta") &&
      points.length > 1 &&
      !rodou_alg) {
    points_unico.clear();
    if (points.length == 2) {
      if (mode_text == "DDA") {
        points_unico = List<Offset>.from(paintDDA(points));
      } else if (mode_text == "Bresenham-Reta") {
        points_unico = List<Offset>.from(paintBresenhamGeneric(points));
      }
      points.clear();
      attPoints(points_unico);
      updateRodouAlg(true);
    } else {
      List<Offset> ultimosElementos = [];
      ultimosElementos.addAll(points.sublist(points.length - 2));
      points.removeRange(points.length - 2, points.length);

      if (mode_text == "DDA") {
        ultimosElementos = paintDDA(ultimosElementos);
      } else if (mode_text == "Bresenham-Reta") {
        ultimosElementos = paintBresenhamGeneric(ultimosElementos);
      }
      attPoints(ultimosElementos);
      updateRodouAlg(true);
    }
  } else {
    updateRodouAlg(false);
  }
}
