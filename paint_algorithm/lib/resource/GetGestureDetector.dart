import 'package:flutter/material.dart';

// meus imports
import '../algorithms/dda.dart';
import "../algorithms/bresenham.dart";

// ignore: must_be_immutable
class GetGestureMouse extends StatefulWidget {
  final List<Offset> points;
  final Function(List<Offset>) attPoints;
  final String mode_text;
  final Function(bool) updateRodouAlg;
  bool rodou_alg;

  GetGestureMouse(
      {super.key,
      required this.attPoints,
      required this.mode_text,
      required this.points,
      required this.rodou_alg,
      required this.updateRodouAlg});

  @override
  State<GetGestureMouse> createState() => _GetGestureMouseState();
}

class _GetGestureMouseState extends State<GetGestureMouse> {
  List<Offset> points_unico = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          if (!points_unico.contains(Offset(
              details.localPosition.dx.roundToDouble(),
              details.localPosition.dy.roundToDouble()))) {
            points_unico.clear();
            points_unico.add(Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            widget.attPoints(points_unico);
          }
        });
      },
      onPanUpdate: (details) {
        setState(() {
          if (!points_unico.contains(Offset(
              details.localPosition.dx.roundToDouble(),
              details.localPosition.dy.roundToDouble()))) {
            points_unico.clear();
            points_unico.add(Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            widget.attPoints(points_unico);
          }
        });
      },
      onTapDown: (details) {
        if (!points_unico.contains(Offset(
            details.localPosition.dx.roundToDouble(),
            details.localPosition.dy.roundToDouble()))) {
          points_unico.clear();
          points_unico.add(Offset(details.localPosition.dx.roundToDouble(),
              details.localPosition.dy.roundToDouble()));
          widget.attPoints(points_unico);

          checkDDAorBresenham(widget.mode_text, widget.points, widget.attPoints,
              widget.updateRodouAlg, points_unico, widget.rodou_alg);
        }
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
        points_unico = List<Offset>.from(paintBresenham(points));
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
        ultimosElementos = paintBresenham(ultimosElementos);
      }
      attPoints(ultimosElementos);
      updateRodouAlg(true);
    }
  } else {
    updateRodouAlg(false);
  }
}
