import 'package:flutter/material.dart';
import 'package:paint_algorithm/class/Points.dart';

// meus imports
import '../algorithms/dda.dart';
import '../algorithms/bresenham.dart';
import 'Util.dart';
import "../class/Object.dart";

// ignore: must_be_immutable
class GetGestureMouse extends StatefulWidget {
  final Function(List<Points>) attPoints;
  final Function(List<Object>) attListaObject;
  final String mode_text;
  final Function(int) updatePixelID_gesture_detector;
  final List<Points> points_class;
  List<Object> lista_objetos;
  int pixel_id;

  GetGestureMouse({
    super.key,
    required this.attListaObject,
    required this.lista_objetos,
    required this.points_class,
    required this.updatePixelID_gesture_detector,
    required this.pixel_id,
    required this.attPoints,
    required this.mode_text,
  });

  @override
  State<GetGestureMouse> createState() => _GetGestureMouseState();
}

class _GetGestureMouseState extends State<GetGestureMouse> {
  Offset points_unico = Offset(0.0, 0.0);
  bool trava = false;
  final List<Offset> save_pontos_att = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          if (widget.mode_text == "Painter") {
            Points newObject = new Points();
            if (!newObject.isList(
                widget.points_class,
                Offset(details.localPosition.dx.roundToDouble(),
                    details.localPosition.dy.roundToDouble()))) {
              points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                  details.localPosition.dy.roundToDouble()));
              newObject.setOffset(points_unico);
              newObject.setPixelId(widget.pixel_id);
              widget.attPoints([newObject]);
            }
          }
        });
      },
      onPanUpdate: (details) {
        setState(() {
          if (widget.mode_text == "Painter") {
            Points newObject = new Points();
            if (!newObject.isList(
                widget.points_class,
                Offset(details.localPosition.dx.roundToDouble(),
                    details.localPosition.dy.roundToDouble()))) {
              points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                  details.localPosition.dy.roundToDouble()));
              newObject.setOffset(points_unico);
              newObject.setPixelId(widget.pixel_id);
              widget.attPoints([newObject]);
            }
          }
        });
      },
      onTapDown: (details) {
        Points newObject = new Points();
        if (!newObject.isList(
            widget.points_class,
            Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()))) {
          points_unico = (Offset(details.localPosition.dx.roundToDouble(),
              details.localPosition.dy.roundToDouble()));
          newObject.setOffset(points_unico);
          newObject.setPixelId(widget.pixel_id);
          widget.attPoints([newObject]);

          // TEM QUE MELHORAR A LOGICA DESSE IF AQUI <----------------------------------------------------------------------------------------------

          checkDDAorBresenham(
            widget.mode_text,
            save_pontos_att,
            points_unico,
            widget.points_class,
            widget.attPoints,
            widget.lista_objetos,
            widget.attListaObject,
          );
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
  List<Offset> save_pontos_att,
  Offset points_unico,
  List<Points> points_class,
  Function(List<Points>) attPoints,
  List<Object> lista_objetos,
  Function(List<Object>) attListaObject,
) {
  // Lista para verificar se são pontos distintos, para não partir da ultima reta desenhada
  if ((mode_text == "DDA" || mode_text == "Bresenham-Reta")) {
    save_pontos_att.add(points_unico);
    if (save_pontos_att.length == 2) {
      Util obj = new Util();
      if (lista_objetos.length != 0) {
        lista_objetos = obj.createListObject(points_class);
      } else {
        lista_objetos = obj.createListObject(points_class);
      }

      if (mode_text == "DDA" && lista_objetos.length != 0) {
        Object objeto_inicial = lista_objetos[lista_objetos.length - 2];
        Object objeto_final = lista_objetos[lista_objetos.length - 1];

        // conficao de erro para voce não usar por exemplo dda --> paint --> dda se vc ficar alternando o modo buga a lista de objeto
        Points new_instance = new Points();

        if (new_instance.isSoloPixel(objeto_inicial.lista_de_pontos) &&
            new_instance.isSoloPixel(objeto_final.lista_de_pontos)) {
          lista_objetos.remove(objeto_inicial);
          lista_objetos.remove(objeto_final);

          lista_objetos.add(paintDDA(objeto_inicial, objeto_final));

          points_class.clear();

          attPoints(objeto_inicial.objectListtoPointsList(lista_objetos));
          attListaObject(lista_objetos);
          "".toString();
        }
      }
      save_pontos_att.clear();
    }
  }
}
