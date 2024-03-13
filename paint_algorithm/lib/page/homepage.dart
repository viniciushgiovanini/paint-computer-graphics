import 'package:flutter/material.dart';
import "dart:ui";

// Imports
// import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";
import '../resource/GetGestureDetector.dart';

// Classe
import '../class/Points.dart';
import '../class/Object.dart';

// Algs
import '../algorithms/dda.dart';
import '../algorithms/bresenham.dart';
import '../algorithms/bresenhamcirc.dart';
import '../resource/Util.dart';

// ###########################
// Classe do ViewerInteractive
// ###########################
// ignore: must_be_immutable
class ViewerInteractive extends StatefulWidget {
  String mode_text;
  String mode_algoritmo;
  void Function(String) updateStringMode;
  void Function(String) updateModeAlgoritmo;

  ViewerInteractive(
      {super.key,
      required this.mode_text,
      required this.mode_algoritmo,
      required this.updateStringMode,
      required this.updateModeAlgoritmo});

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
              attListaObject: (p0) {
                setState(() {
                  lista_objetos = p0;
                });
              },
              updatePixelId: (p0) {
                setState(() {
                  pixel_id = p0;
                });
                "".toString();
              },
              pixel_id: pixel_id,
              points_class: points_class,
              width: width,
              height: height,
              mode_algoritmo: widget.mode_algoritmo,
              mode_text: widget.mode_text,
              updatePoints: (updatedPoints) {
                points_class.addAll(updatedPoints);
              },
              lista_objetos: lista_objetos,
            ),
          ),
        )),
        VerticalBarScreen(
          lista_objetos: lista_objetos,
          updateModeAlgoritmo: (p0) {
            widget.updateModeAlgoritmo(p0);
          },
          points_class: points_class,
          updatePixelId: (p0) {
            setState(() {
              pixel_id = p0;
            });
          },
          updateMode: (txt_mode) {
            widget.updateStringMode(txt_mode);
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CanvaWidget extends StatefulWidget {
  final List<Points> points_class;
  final Function(List<Object>) attListaObject;
  final double width;
  final double height;
  final Function(List<Points>) updatePoints;
  final Function(int) updatePixelId;
  final int pixel_id;
  final List<Object> lista_objetos;
  final String mode_algoritmo;

  final String mode_text;

  CanvaWidget({
    super.key,
    required this.attListaObject,
    required this.lista_objetos,
    required this.pixel_id,
    required this.updatePixelId,
    required this.points_class,
    required this.width,
    required this.height,
    required this.updatePoints,
    required this.mode_text,
    required this.mode_algoritmo,
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
          painter: Canva(
            points_class: widget.points_class,
            lista_de_objetos: widget.lista_objetos,
            mode_algoritmo: widget.mode_algoritmo,
            mode_text: widget.mode_text,
          ),
          child: GetGestureMouse(
            attListaObject: (p0) {
              widget.attListaObject(p0);
            },
            points_class: widget.points_class,
            updatePixelID_gesture_detector: (p0) {
              widget.updatePixelId(p0);
            },
            pixel_id: widget.pixel_id,
            mode_text: widget.mode_text,
            mode_algoritmo: widget.mode_algoritmo,
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
  final List<Object> lista_de_objetos;
  String mode_algoritmo = "";
  String mode_text = "";

  Canva({
    required this.points_class,
    required this.lista_de_objetos,
    required this.mode_algoritmo,
    required this.mode_text,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 1.0;

    // Paint backgroundPaint = Paint()..color = Color.fromARGB(127, 243, 240, 211);
    Paint backgroundPaint = Paint()..color = Color.fromARGB(240, 255, 255, 255);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    if (points_class.length >= 1) {
      points_class.forEach((point) {
        canvas.drawPoints(PointMode.points, [point.ponto], paint);
      });
    }
    if (lista_de_objetos.length >= 1) {
      paintLineOrCirc(
          lista_de_objetos, mode_text, mode_algoritmo, canvas, paint);
      "".toString();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void paintLineOrCirc(
  List<Object> lista_de_objetos,
  String mode_text,
  String mode_algoritmo,
  Canvas canvas,
  Paint paint,
) {
  if (mode_algoritmo == "DDA") {
    lista_de_objetos.forEach((element) {
      if (setTwoPoints(element)) {
        print("AAAAAAAAAAAAAAAA");
        "".toString();
        canvas.drawPoints(
            PointMode.points,
            paintDDA(element.lista_de_pontos[0], element.lista_de_pontos[1]),
            paint);
      } else {
        canvas.drawPoints(
            PointMode.points,
            [
              Offset(
                  lista_de_objetos[lista_de_objetos.length - 1]
                      .lista_de_pontos[0]
                      .ponto
                      .dx,
                  lista_de_objetos[lista_de_objetos.length - 1]
                      .lista_de_pontos[0]
                      .ponto
                      .dy)
            ],
            paint);
      }
    });
  }
}

bool setTwoPoints(Object objeto) {
  if (objeto.lista_de_pontos.length >= 2) {
    return true;
  }
  return false;
}
