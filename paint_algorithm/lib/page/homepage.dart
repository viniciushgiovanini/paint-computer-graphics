import 'package:flutter/material.dart';
import "dart:ui";

// Imports
// import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";
import '../resource/GetGestureDetector.dart';

// Classe
import '../class/Object.dart';

// Algs
import '../algorithms/dda.dart';
import '../algorithms/bresenham.dart';
import '../algorithms/bresenhamcirc.dart';

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
  List<Offset> points_class = [];
  final double width = 300;
  final double height = 300.5;
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
              points_class: points_class,
              width: width,
              height: height,
              mode_algoritmo: widget.mode_algoritmo,
              mode_text: widget.mode_text,
              updateOffset: (updatedPoints) {
                points_class.addAll(updatedPoints);
              },
              lista_objetos: lista_objetos,
            ),
          ),
        )),
        VerticalBarScreen(
          mode_text: widget.mode_text,
          attListaObject: (p0) {
            setState(() {
              lista_objetos = p0;
              "".toString();
            });
          },
          lista_objetos: lista_objetos,
          updateModeAlgoritmo: (p0) {
            widget.updateModeAlgoritmo(p0);
          },
          points_class: points_class,
          updateMode: (txt_mode) {
            bool encontrado = false;

            for (var objeto in lista_objetos) {
              if (objeto.type == "Reta_do_Poligono") {
                encontrado = true;
                break;
              }
            }

            if (!encontrado) {
              widget.updateStringMode(txt_mode);
            }
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CanvaWidget extends StatefulWidget {
  final List<Offset> points_class;
  final Function(List<Object>) attListaObject;
  final double width;
  final double height;
  final Function(List<Offset>) updateOffset;
  final List<Object> lista_objetos;
  final String mode_algoritmo;
  final String mode_text;

  CanvaWidget({
    super.key,
    required this.attListaObject,
    required this.lista_objetos,
    required this.points_class,
    required this.width,
    required this.height,
    required this.updateOffset,
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
              setState(() {
                widget.attListaObject(p0);
              });
            },
            points_class: widget.points_class,
            mode_text: widget.mode_text,
            mode_algoritmo: widget.mode_algoritmo,
            attOffset: (pontos_att) {
              setState(() {
                widget.updateOffset(pontos_att);
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
  List<Offset> points_class = [];
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
        canvas.drawPoints(PointMode.points, [point], paint);
      });
    }
    if (lista_de_objetos.length >= 1) {
      paintVerify(lista_de_objetos, mode_text, mode_algoritmo, canvas, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

bool setTwoPoints(Object objeto) {
  if (objeto.lista_de_pontos.length >= 2) {
    return true;
  }
  return false;
}

void paintVerify(List<Object> lista_de_objetos, String mode_text,
    String mode_algoritmo, Canvas canvas, Paint paint) {
  lista_de_objetos.forEach((element) {
    if (element.type != "Ponto" && element.type != "Circunferencia") {
      if (mode_algoritmo == "DDA") {
        paintRetas(mode_text, mode_algoritmo, canvas, paint, element, paintDDA);
      } else {
        paintRetas(mode_text, mode_algoritmo, canvas, paint, element,
            paintBresenhamGeneric);
      }
    } else if (element.type == "Circunferencia") {
      canvas.drawPoints(
          PointMode.points,
          paintCirc(element.lista_de_pontos[element.lista_de_pontos.length - 2],
              element.lista_de_pontos[element.lista_de_pontos.length - 1]),
          paint);
    } else {
      canvas.drawPoints(
          PointMode.points,
          [
            Offset(
                lista_de_objetos[lista_de_objetos.length - 1]
                    .lista_de_pontos[0]
                    .dx,
                lista_de_objetos[lista_de_objetos.length - 1]
                    .lista_de_pontos[0]
                    .dy)
          ],
          paint);
    }
  });
}

void paintRetas(
  String mode_text,
  String mode_algoritmo,
  Canvas canvas,
  Paint paint,
  Object element,
  Function paintFunction,
) {
  for (int i = 0; i < element.lista_de_pontos.length - 1; i++) {
    Offset elemento_atual = element.lista_de_pontos[i];
    Offset elemento_prox = element.lista_de_pontos[i + 1];

    canvas.drawPoints(
        PointMode.points, paintFunction(elemento_atual, elemento_prox), paint);
  }
  if (element.type == "Poligono") {
    Offset elemento_atual =
        element.lista_de_pontos[element.lista_de_pontos.length - 1];
    Offset elemento_prox = element.lista_de_pontos[0];
    canvas.drawPoints(
        PointMode.points, paintFunction(elemento_atual, elemento_prox), paint);
  }
}
