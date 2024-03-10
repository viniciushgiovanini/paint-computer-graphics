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
  final String mode_text;
  final Function(int) updatePixelID_gesture_detector;
  final List<Points> points_class;
  List<Object> lista_objetos;
  int pixel_id;

  GetGestureMouse({
    super.key,
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

          // checkDDAorBresenham(
          //   widget.mode_text,
          //   save_pontos_att,
          //   points_unico,
          //   widget.points_class,
          //   widget.attPoints,
          //   widget.lista_objetos,
          // );
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
) {
  // Lista para verificar se são pontos distintos, para não partir da ultima reta desenhada
  save_pontos_att.add(points_unico);

  if ((mode_text == "DDA" || mode_text == "Bresenham-Reta") &&
      save_pontos_att.length == 2) {
    Util obj = new Util();
    if (lista_objetos.length != 0) {
      Object ultimo_elemento = lista_objetos[lista_objetos.length - 1];

      Points ultimo_ponto_do_vetor = points_class[points_class.length - 1];
      if (ultimo_ponto_do_vetor.id_pixel != ultimo_elemento.lastId) {
        lista_objetos = obj.createListObject(points_class);
      }
    } else {
      lista_objetos = obj.createListObject(points_class);
      "".toString();
    }

    // TEM QUE FAZER AGORA O DDA ATUALIZAR A LISTA DE OBJETO COM A RETA, FAZENDO MERGE DOS DOIS OBJETOS EM UM SO
    // E AINDA FALTA AS CALLBACK

    if (mode_text == "DDA") {
      Object objeto_inicial = lista_objetos[lista_objetos.length - 2];
      Object objeto_final = lista_objetos[lista_objetos.length - 1];

      lista_objetos.remove(objeto_inicial);
      lista_objetos.remove(objeto_final);
      lista_objetos.add(paintDDA(objeto_inicial, objeto_final));
      // points_class = [];
      "".toString();

      // Atualizando vetor que atualiza a tela
      points_class.remove(objeto_inicial.lista_de_pontos[0].ponto);
      points_class.remove(objeto_final.lista_de_pontos[0].ponto);
      List<Points> objetos_todos_em_list_points =
          objeto_inicial.objectListtoPointsList(lista_objetos);
      // points_class.addAll(objetos_todos_em_list_points);
      attPoints(objetos_todos_em_list_points);
    }
    save_pontos_att.clear();
  }
}
