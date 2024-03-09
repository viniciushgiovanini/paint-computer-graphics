import 'package:flutter/material.dart';

// meus imports
import '../algorithms/dda.dart';

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

          if (widget.mode_text == "DDA" &&
              widget.points.length > 1 &&
              !widget.rodou_alg) {
            points_unico.clear();
            if (widget.points.length == 2) {
              points_unico = List<Offset>.from(paintDDA(widget.points));
              widget.points.clear();
              widget.attPoints(points_unico);
              widget.updateRodouAlg(true);
            } else {
              List<Offset> ultimosElementos = [];
              ultimosElementos
                  .addAll(widget.points.sublist(widget.points.length - 2));
              widget.points
                  .removeRange(widget.points.length - 2, widget.points.length);

              ultimosElementos = paintDDA(ultimosElementos);
              widget.attPoints(ultimosElementos);
              widget.updateRodouAlg(true);
            }
          } else {
            widget.updateRodouAlg(false);
          }
        }
      },
    );
  }
}
